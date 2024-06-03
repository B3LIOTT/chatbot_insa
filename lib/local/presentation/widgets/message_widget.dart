import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter/material.dart';


class MessageWidget extends StatelessWidget {
  final Message message;
  final Map<String, Color> theme;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme['message'],
          borderRadius: BorderRadius.circular(8),
        ),
        child: !message.hasError? Text(
          message.message,
          style: TextStyle(
            color: theme['text'],
          ),
        ) : Text(
            "Erreur",
            style: const TextStyle(
              color: Colors.white,
            ),
        ),
      ),
    );
  }
}