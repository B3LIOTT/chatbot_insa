import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter/material.dart';


class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: message.sender=='bot' ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: !message.hasError? Text(
        message.message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ) : Text(
          "Erreur",
          style: const TextStyle(
            color: Colors.white,
          ),
      ),
    );
  }
}