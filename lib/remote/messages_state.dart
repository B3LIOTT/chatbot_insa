import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter/material.dart';


@immutable
class MessagesState {
  final bool isLoading;
  final bool hasError;
  final List<Message> messages;


  const MessagesState({
    this.isLoading = false,
    this.hasError = false,
    this.messages = const [],
  });

  /*
  copyWith({}) {
    return MessageState();
  }
   */
}