import 'package:chatbot_insa/local/models/message.dart';
import 'package:chatbot_insa/local/presentation/providers/messages_state_provider.dart';
import 'package:chatbot_insa/local/presentation/widgets/loading_message.dart';
import 'package:chatbot_insa/local/presentation/widgets/message_widget.dart';
import 'package:chatbot_insa/local/presentation/widgets/pop_up.dart';
import 'package:chatbot_insa/remote/messages_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_theme.dart';


/// Widget qui affiche la zone de chat
///
class ChatZone extends ConsumerStatefulWidget {
  final ValueChanged<bool> update;

  const ChatZone({required this.update, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatZoneState();
}

class _ChatZoneState extends ConsumerState<ChatZone>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollDown();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  // Lors de l"ouverture du clavier, on scroll en bas
  @override
  void didChangeMetrics() {
    _scrollDown();
  }

  /// Affiche une popup avec un message d'erreur
  ///
  void _loadPopup(String message, MessagesState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) => PopUp(
                title: "Erreur",
                content: message,
                buttonText: "OK",
                isWarning: true,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                },
              ));
      ref
          .read(messagesStateProvider.notifier)
          .updateState(state.copyWith(hasError: false, isLoading: false));
    });
  }


  /// Scroll en bas
  ///
  void _scrollDown() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(messagesStateProvider);
    List<Message> messages = state.messages;
    _scrollDown();

    // gestion de l'erreur coté messages
    if (state.hasError) {
      _loadPopup("Une erreur est survenue", state);
    }

    // gestion de la connexion
    if (!state.isConnected) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        widget.update(false);
      });
    }

    return Column(  
      children: [
        Expanded(
          child: ListView.builder(
            reverse: false,
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            itemCount: messages.length + 2,
            itemBuilder: (context, index) {

              // ---- PADDING ----
              if(index == 0) {
                return SizedBox(height: MediaQuery.of(context).size.height * 0.1);
              }
              // -----------------

              // Animation de l'attente lors du traitement serveur
              if (index == messages.length+1) {
                return Column(
                  children: [
                    state.isLoading
                        ? const Align(
                      alignment: Alignment.centerLeft,
                      child: LoadingMessageWidget(),
                    )
                        : Container(),
                    const SizedBox(height: 30),
                  ],
                );
              }

              // condition d'animation du widget message (si l'id du message est celui du nouveau message)
              int messageIndex = index - 1;
              bool animationCond = (state.newMessageId == messages[messageIndex].id);

              if (messages[messageIndex].sender == 'user') {
                final theme = AppTheme.getUserTheme();
                return Align(
                  alignment: Alignment.centerRight,
                  child: MessageWidget(
                      animate: animationCond,
                      message: messages[messageIndex],
                      theme: theme),
                );
              } else {
                final theme = AppTheme.getBotTheme();
                return Align(
                  alignment: Alignment.centerLeft,
                  child: MessageWidget(
                      animate: animationCond,
                      message: messages[messageIndex],
                      theme: theme),
                );
              }
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }
}
