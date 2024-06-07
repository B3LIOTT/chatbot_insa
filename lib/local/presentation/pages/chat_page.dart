import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_zone.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        const ChatZone(),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: h*0.1,
            decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                border: const Border(
                    bottom: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 3
                    )
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.black.withOpacity(0.12),
                      blurRadius: 10,
                      offset: const Offset(0, 5)
                  )
                ]
            ),
            child: const Center(
              child: Text(
                "ChatBot INSA",
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5
                ),
              ),
            ),
          ),
        ),
        const Align(
            alignment: Alignment.bottomCenter,
            child: PromptTextFiled()
        ),
      ],
    );
  }
}