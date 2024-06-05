import 'package:chatbot_insa/local/models/message.dart';
import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'messages_state.dart';


class MessageStateNotifier extends StateNotifier<MessagesState> {

  MessageStateNotifier() : super(MessagesState(
    isLoading: false,
    hasError: false,
    messages: LocalStorage.getMessages(),
  ));

  void updateState(MessagesState newState) {
    state = newState;
  }

  Future<void> addMessage({required String message, required String sender, required String receiver}) async {
    int nMessage = state.messages.length;
    int id = nMessage + 1;
    Message newMessage = Message(
      id: id,
      message: message,
      sender: "user",
      receiver: "bot",
      timestamp: DateTime.now().toIso8601String(),
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
}