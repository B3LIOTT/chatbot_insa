import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/presentation/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  Widget build(BuildContext context) {
    //final state = ref.watch(connectionStateProvider);

    return const Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: ChatPage(),
      ),
    );
  }
}