import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/messages_state_provider.dart';


class PromptTextFiled extends ConsumerStatefulWidget {
  const PromptTextFiled({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PromptTextFiledState();
}

class _PromptTextFiledState extends ConsumerState<PromptTextFiled> with SingleTickerProviderStateMixin {
  String _message = "";
  TextEditingController _controller = TextEditingController();
  late AnimationController _ac;
  late Animation<double> _a;


  @override
  void initState() {
    _ac = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _a = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _ac,
        curve: Curves.easeInBack,
      )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ac.reverse();
        }
      }),
    );
    super.initState();
  }


  Widget sendButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: _a,
        builder: (context, child) {
          return Transform.scale(
            scale: _a.value,
            child: Card(
              elevation: 4,
              surfaceTintColor: AppTheme.white,
              color: AppTheme.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: SizedBox(
                  height: 50,
                  width: 50,
                  child: IconButton(
                      icon: const Icon(
                        Icons.send_rounded,
                        color: AppTheme.white,
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        if (_message.isEmpty) return;
                        ref.read(messagesStateProvider.notifier).addMessage(_message);
                        _ac.forward();
                        _controller.clear();
                        _message = "";
                      }
                  )
              ),
            ),
          );
        },
      ),
    );
  }

  Card txtField() {
    return Card(
      elevation: 4,
      surfaceTintColor: AppTheme.white,
      color: AppTheme.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        cursorColor: AppTheme.primaryColor,
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: "Que voulez-vous savoir ?",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppTheme.white
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor
            )
          )
        ),
        onChanged: (value) {
          _message = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: w,
      decoration: BoxDecoration(
        color: AppTheme.white.withAlpha(120),
        border: const Border(
          top: BorderSide(
            color: AppTheme.primaryColor,
            width: 3
          )
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20)
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, -5)
          )
        ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: txtField(),
          ),
          sendButton()
        ],
      ),
    );
  }

}