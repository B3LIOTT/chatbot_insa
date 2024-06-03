import 'package:chatbot_insa/local/models/message.dart';
import 'package:chatbot_insa/local/presentation/providers/messages_state_provider.dart';
import 'package:chatbot_insa/local/presentation/widgets/message_widget.dart';
import 'package:chatbot_insa/local/presentation/widgets/pop_up.dart';
import 'package:chatbot_insa/remote/messages_state.dart';
import 'package:chatbot_insa/remote/messages_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/app_theme.dart';


class ChatZone extends ConsumerStatefulWidget {

  const ChatZone({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatZoneState();
}

class _ChatZoneState extends ConsumerState<ChatZone>
    with TickerProviderStateMixin {



  void _loadPopup(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              PopUp(
                title: "Information",
                content: message,
                buttonText: "OK",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ));
      ref.read(messagesStateProvider.notifier).updateState(const MessagesState(isLoading: false, hasError: false, messages: []));
    });
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messagesStateProvider);
    List<Message> messages = state.messages;
    if (state.hasError) {
      _loadPopup("An error occurred while fetching messages");
    }


    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        if (messages[index].sender == 'user') {
          final theme = AppTheme.getUserTheme();
          return Align(
            alignment: Alignment.centerRight,
            child: MessageWidget(
                message: messages[index],
                theme: theme
            ),
          );
        } else {
          final theme = AppTheme.getBotTheme();
          return Align(
            alignment: Alignment.centerLeft,
            child: MessageWidget(
                message: messages[index],
                theme: theme
            ),
          );
        }
      },
    );
  }
}