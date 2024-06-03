import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_zone.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ChatZone()
            ),
            PromptTextFiled()
          ],
        ),
      ),
    );
  }
}