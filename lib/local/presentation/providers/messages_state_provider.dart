import 'package:chatbot_insa/remote/messages_state.dart';
import 'package:chatbot_insa/remote/messages_state_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Provider pour la gestion de l'état des messages
///
final messagesStateProvider = StateNotifierProvider<MessageStateNotifier, MessagesState>((ref) {
  return MessageStateNotifier();
});