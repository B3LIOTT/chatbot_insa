import 'package:chatbot_insa/remote/messages_state.dart';
import 'package:chatbot_insa/remote/messages_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final messagesStateProvider = StateNotifierProvider<MessageStateNotifier, MessagesState>((ref) {
  return MessageStateNotifier();
});