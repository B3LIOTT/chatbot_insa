import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:flutter/material.dart';


/// Widget qui affiche l'animation de chargement lors de l'attente d'une réponse
/// du serveur
///
class LoadingMessageWidget extends StatefulWidget {
  const LoadingMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LoadingMessageWidgetState createState() => _LoadingMessageWidgetState();
}

class _LoadingMessageWidgetState extends State<LoadingMessageWidget> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final int _dotCount = 3;
  final int _delayIncrement = 150; // Milliseconds delay between dots


  @override
  void initState() {
    super.initState();

    // création des animations
    _controllers = List<AnimationController>.generate(_dotCount, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: 10, // Adjust this value to control the height of the jump
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease,
        ),
      );
    }).toList();

    for (int i = 0; i < _dotCount; i++) {
      Future.delayed(Duration(milliseconds: i * _delayIncrement), () {
        _controllers[i].repeat(reverse: true);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animamtion des points, chacuns décalés de _delayIncrement
          for (int i = 0; i < _dotCount; i++)
            AnimatedBuilder(
              animation: _controllers[i],
              builder: (context, child) {
                return Container(
                  margin: EdgeInsets.only(top: _animations[i].value),
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppTheme.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
