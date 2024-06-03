import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'messages_state.dart';


class MessageStateNotifier extends StateNotifier<MessagesState> {

  MessageStateNotifier() : super(const MessagesState());

  void updateState(MessagesState newState) {
    state = newState;
  }

  void addMessage(String message) {
    Message newMessage = Message(
      id: state.messages.length + 1,
      message: message,
      sender: "user",
      receiver: "bot",
      timestamp: DateTime.now().toIso8601String(),
    );
    final newMessages = MessagesState(messages: [...state.messages, newMessage]);
    updateState(newMessages);
  }
}