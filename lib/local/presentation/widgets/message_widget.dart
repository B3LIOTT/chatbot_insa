import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter/material.dart';

/// Widget permettant d'afficher un [Message]
class MessageWidget extends StatefulWidget {
  final Message message;
  final bool animate;
  final Map<String, Color> theme;

  const MessageWidget({
    Key? key,
    required this.message,
    required this.theme,
    this.animate = false,
  }) : super(key: key);


  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialisation de l'animation du widget s'il est nouveau (animate = true)
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuint,
      ),
    );

    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Liste des metadata à afficher (l'ordre dépend de l'envoyeur du message)
    List<Widget> metadata = [
      Card(
        elevation: 6,
        surfaceTintColor: AppTheme.white,
        color: widget.theme['ui']!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            widget.message.sender=='user'? Icons.person : Icons.computer,
            color: AppTheme.white,
            size: 10,
          ),
        ),
      ),
      Card(
          elevation: 6,
          surfaceTintColor: AppTheme.white,
          color: widget.theme['ui']!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${DateTime.parse(widget.message.timestamp).hour}:${DateTime.parse(widget.message.timestamp).minute}",
              style: const TextStyle(color: AppTheme.white, fontSize: 10),
            ),)
      ),
    ];

    // Liste des widgets à afficher incluant le message et les metadata
    List<Widget> children = [
      Card(
        elevation: 6,
        shadowColor: AppTheme.black.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(8),
        child: Container(
          constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
        ),
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              color: !widget.message.hasError? AppTheme.white : AppTheme.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border(
                bottom: BorderSide(width: 4, color:  !widget.message.hasError? widget.theme['ui']! : AppTheme.red),
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: !widget.message.hasError
                  ? Text(
                widget.message.message,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: widget.theme['text'], fontSize: 16),
              )
                  : const Text(
                "Erreur",
                style: TextStyle(
                    color: AppTheme.red, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.message.sender == 'bot'? metadata
        : metadata.reversed.toList()
      ),
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: widget.animate? _animation.value : 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: widget.message.sender == 'bot'? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: children,
          ),
        );
      },
    );
  }
}
