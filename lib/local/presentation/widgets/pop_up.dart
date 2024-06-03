import 'package:flutter/material.dart';


class PopUp extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final void Function() onPressed;

  PopUp({required this.title, required this.content, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(buttonText),
          onPressed: onPressed,
        ),
      ],
    );
  }
}