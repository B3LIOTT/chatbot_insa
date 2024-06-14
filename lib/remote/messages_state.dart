import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter/material.dart';


/// Classe qui représente l'état de la liste des messages
/// de la connexion avec le serveur
/// et des éventuelles erreurs
///
@immutable
class MessagesState {
  final bool isLoading;
  final bool hasError;
  final int newMessageId;
  final List<Message> messages;
  final bool isConnected;


  const MessagesState({
    this.isLoading = false,
    this.hasError = false,
    this.newMessageId = -1,
    this.messages = const [],
    this.isConnected = true,
  });


  /// Méthode qui permet de copier l'état actuel avec des modifications précises
  ///
  copyWith({
    bool? isLoading,
    bool? hasError,
    int? newMessageId,
    List<Message>? messages,
    bool? isConnected,
  }) {
    return MessagesState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      newMessageId: newMessageId ?? this.newMessageId,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  String toString() {
    return 'MessagesState{isLoading: $isLoading, hasError: $hasError, newMessageId: $newMessageId, messages: $messages, isConnected: $isConnected}';
  }

}