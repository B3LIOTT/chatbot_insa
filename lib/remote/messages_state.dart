import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter/material.dart';


@immutable
class MessagesState {
  final bool isLoading;
  final bool hasError;
  final int newMessageId;
  final List<Message> messages;
  final bool isSocketConnected;


  const MessagesState({
    this.isLoading = false,
    this.hasError = false,
    this.newMessageId = -1,
    this.messages = const [],
    this.isSocketConnected = true,
  });

  copyWith({
    bool? isLoading,
    bool? hasError,
    int? newMessageId,
    List<Message>? messages,
    bool? isSocketConnected,
  }) {
    return MessagesState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      newMessageId: newMessageId ?? this.newMessageId,
      messages: messages ?? this.messages,
      isSocketConnected: isSocketConnected ?? this.isSocketConnected,
    );
  }

}