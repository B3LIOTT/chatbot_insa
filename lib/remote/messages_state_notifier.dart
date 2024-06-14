import 'package:chatbot_insa/local/config/env_loader.dart';
import 'package:chatbot_insa/local/models/message.dart';
import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'messages_state.dart';

/// Classe qui permet de notifier les changements d'état de la connexion
/// avec le serveur et de la liste des messages
///
class MessageStateNotifier extends StateNotifier<MessagesState> {

  MessageStateNotifier() : super(MessagesState(
    isLoading: false,
    hasError: false,
    messages: LocalStorage.getMessages(),
    isConnected: false,
  ));

  /// Méthode qui permet de mettre à jour l'état actuel
  void updateState(MessagesState newState) {
    state = newState;
  }

  /// Méthode qui permet d'ajouter un message à la liste des messages
  ///
  void addMessage({required String message, required String sender, required String receiver, bool hasError = false}) {
    int nMessage = state.messages.length;
    int id = nMessage + 1;
    Message newMessage = Message(
      id: id,
      message: message,
      sender: sender,
      receiver: receiver,
      timestamp: DateTime.now().toIso8601String(),
      hasError: false,
    );
    List<Message> newMessages = List.from(state.messages)..add(newMessage);
    final newMessagesState = MessagesState(messages: newMessages, newMessageId: id);
    updateState(newMessagesState);
    LocalStorage.setMessages(newMessages);
  }

  /// Méthode qui permet d'ajouter un mot au dernier message recu, basé sur le
  /// mode stream de la reception des messages
  ///
  void addWord({required String word}) {
    int nMessage = state.messages.length;
    Message updatedMessage = Message(
      id: nMessage,
      message: '${state.messages[nMessage - 1].message} $word',
      sender: 'bot',
      receiver: 'user',
      timestamp: DateTime.now().toIso8601String(),
      hasError: false,
    );
    List<Message> newMessages = List.from(state.messages)..removeLast()..add(updatedMessage);
    final newMessagesState = MessagesState(messages: newMessages, newMessageId: -1);
    updateState(newMessagesState);
    LocalStorage.setMessages(newMessages);
  }


  // Initialisation du socket
  IO.Socket socket = IO.io(EnvLoader.socketUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });


  /// Méthode qui permet d'initialiser le socket et de définir les différents
  /// événements qui peuvent être reçus du serveur
  ///
  void initSocket() {
      socket.onConnect((_) {
        if (kDebugMode) {
          print('Connected to the server');
        }
        updateState(state.copyWith(isConnected: true));
      });

      socket.onDisconnect((_) {
        if(kDebugMode) {
          print('Disconnected from the server');
        }
        updateState(state.copyWith(isLoading: false, isConnected: false));
      });

      socket.on(EnvLoader.loadingEvent, (data) {
        if (kDebugMode) {
          print('Received LOADING event from server: $data');
        }
        updateState(state.copyWith(isLoading: true));
      });

      socket.on(EnvLoader.receivedMessageEvent, (data) {
        if (kDebugMode) {
          print('Received MESSAGE from server: $data');
        }
        addMessage(message: data['message'], sender: 'bot', receiver: 'user');
      });
      socket.on(EnvLoader.newWordEvent, (data) {
        if (kDebugMode) {
          print('Received WORD from server: $data');
        }
        addWord(word: data['word']);
      });

      socket.on(EnvLoader.errorEvent, (data) {
        if (kDebugMode) {
          print('Received error from server: $data');
        }
        updateState(state.copyWith(hasError: true));
      });

      socket.on(EnvLoader.disconnectEvent, (data) {
        socket.disconnect();
        if(kDebugMode) {
          print('Disconnected from the server');
        }
        updateState(state.copyWith(isLoading: false, isConnected: false));
      });

      socket.onError((data) {
        if (kDebugMode) {
          print('Error: $data');
        }
        socket.dispose();
        updateState(state.copyWith(hasError: true, isConnected: false));
      });

      socket.onDisconnect((_) {
        socket.dispose();
        updateState(state.copyWith(isConnected: false));
      });

    socket.connect();
  }

  /// Méthode qui permet d'envoyer un message au serveur
  ///
  void sendMessage({
    required String message,
  }) async {
    if(state.isLoading) {
      return;
    }
    String accessToken = await LocalStorage.getAccessToken();
    socket.emit(EnvLoader.sendMessageEvent, {
      'access_token': accessToken,
      'message': message,
    });
    if(kDebugMode) {
      print('Sent message to the server: $message');
    }
    addMessage(message: message, sender: 'user', receiver: 'bot');
  }


  /// Méthode qui permet de se déconnecter du serveur, pour éviter de laisser
  /// des sockets ouverts inutilement
  ///
  void disconnect() {
    socket.disconnect();
    if(kDebugMode) {
      print('Disconnected from the server');
    }
    updateState(state.copyWith(isLoading: false));
  }
}
