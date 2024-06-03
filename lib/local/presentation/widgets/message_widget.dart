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
        child: Card(
          elevation: 6,
          shadowColor: AppTheme.black.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(8),
          child: Container(
            margin: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              border: Border(
                bottom: BorderSide(width: 4, color: theme['ui']!),
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: !message.hasError
                    ? Text(
                        message.message,
                        style: TextStyle(color: theme['text'], fontSize: 20),
                      )
                    : const Text(
                        "Erreur",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
              ),
            ),
          ),
        ));
  }
}
