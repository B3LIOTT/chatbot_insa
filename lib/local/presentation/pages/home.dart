import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/presentation/pages/connection_check.dart';
import 'package:chatbot_insa/local/presentation/providers/messages_state_provider.dart';
import 'package:chatbot_insa/local/presentation/widgets/chat_zone.dart';
import 'package:chatbot_insa/local/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isConnected = false;


  void _updateSocketStatus(bool status) {
    setState(() {
      _isConnected = status;
    });
  }

  @override
  void dispose() {
    super.dispose();
    ref.read(messagesStateProvider.notifier).socket.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: _isConnected? Stack(
          children: [
            ChatZone(update: _updateSocketStatus),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: h*0.08,
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
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              fontSize: 30,
                              wordSpacing: 0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 3
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Talk', style: TextStyle(color: AppTheme.primaryColor,)),
                            TextSpan(text: ' 2', style: TextStyle(color: AppTheme.red,)),
                            TextSpan(text: ' Eve', style: TextStyle(color: AppTheme.secondaryColor,)),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.search,
                        color: AppTheme.primaryColor,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: PromptTextFiled()
            ),
          ],
        )
            : ConnexionCheck(update: _updateSocketStatus)
      ),
    );
  }
}