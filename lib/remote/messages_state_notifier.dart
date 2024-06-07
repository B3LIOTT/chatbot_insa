import 'package:chatbot_insa/local/config/env_loader.dart';
import 'package:chatbot_insa/local/models/message.dart';
import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'messages_state.dart';


class MessageStateNotifier extends StateNotifier<MessagesState> {

  MessageStateNotifier() : super(MessagesState(
    isLoading: false,
    hasError: false,
    messages: LocalStorage.getMessages(),
    isSocketConnected: false,
  ));

  void updateState(MessagesState newState) {
    state = newState;
  }

  Future<void> addMessage({required String message, required String sender, required String receiver, bool hasError = false}) async {
    int nMessage = state.messages.length;
    int id = nMessage + 1;
    Message newMessage = Message(
      id: id,
      message: message,
      sender: "user",
      receiver: "bot",
      timestamp: DateTime.now().toIso8601String(),
      hasError: false,
    );
    List<Message> newMessages = List.from(state.messages)..add(newMessage);
    final newMessagesState = MessagesState(messages: newMessages, newMessageId: id);
    updateState(newMessagesState);
    LocalStorage.setMessages(newMessages);

    // Simulate bot response
    await Future.delayed(const Duration(seconds: 1), () {
      final newMessagesState = MessagesState(messages: newMessages, isLoading: true);
      updateState(newMessagesState);
    });
    Future.delayed(const Duration(seconds: 2), () {
      int nMessage = state.messages.length;
      int id = nMessage + 1;
      Message newMessage = Message(
        id: id,
        message: "Tg.",
        sender: "bot",
        receiver: "user",
        timestamp: DateTime.now().toIso8601String(),
      );
      List<Message> newMessages = List.from(state.messages)..add(newMessage);
      final newMessagesState = MessagesState(messages: newMessages, newMessageId: id);
      updateState(newMessagesState);
      LocalStorage.setMessages(newMessages);
    });
  }


  io.Socket socket = io.io(EnvLoader.socketAddress, <String, dynamic>{
    'transports': ['websocket'],
    'extraHeaders': {'x-api-key': EnvLoader.apiKEY},
    'autoConnect': false,
  });


  void sendMessage({
    required String message,
  }) => socket.emit(EnvLoader.sendMessageEvent, {
    'message': message,
  });

  void disconnect() {
    socket.emit(EnvLoader.disconnectEvent, {});
    socket.disconnect();
    if(kDebugMode) {
      print('Disconnected from the server');
    }
    updateState(state.copyWith(isLoading: false));
  }


  void initSocket() {
    try {
      socket.connect();

      socket.onConnect((_) {
        if (kDebugMode) {
          print('Connected to the server');
        }
        updateState(state.copyWith(isSocketConnected: true));
      });

      socket.onDisconnect((_) {
        if(kDebugMode) {
          print('Disconnected from the server');
        }
        updateState(state.copyWith(isLoading: false, isSocketConnected: false));
      });

      socket.on(EnvLoader.loadingEvent, (data) {
        if (kDebugMode) {
          print('Received loading event from server: $data');
        }
        updateState(const MessagesState(isLoading: true));
      });

      socket.on(EnvLoader.receivedMessageEvent, (data) {
        if (kDebugMode) {
          print('Received data from server: $data');
        }
        addMessage(message: data['message'], sender: 'bot', receiver: 'user');
      });

      socket.on(EnvLoader.rejectMessageEvent, (data) {
        if (kDebugMode) {
          print('Received data from server: $data');
        }
        addMessage(message: data['message'], sender: 'bot', receiver: 'user');
      });

      socket.on(EnvLoader.disconnectEvent, (data) {
        socket.disconnect();
        if(kDebugMode) {
          print('Disconnected from the server');
        }
        updateState(state.copyWith(isLoading: false, isSocketConnected: false));
      });

      socket.onError((data) => updateState(const MessagesState(hasError: true, isSocketConnected: false)));
    } catch (e) {
      updateState(const MessagesState(hasError: true, isSocketConnected: false));
    }
  }

}