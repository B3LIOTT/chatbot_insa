import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:flutter/material.dart';


class PopUp extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final bool isWarning;
  final void Function() onPressed;

  PopUp({required this.title, required this.content, required this.buttonText, required this.onPressed, this.isWarning = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: AppTheme.white,
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: Container(
              decoration: BoxDecoration(
                color: isWarning? AppTheme.secondaryColor: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                  child: Text(
                      buttonText,
                    style: const TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.w500),
                  )
              )
          ),
        ),
      ],
    );
  }
}