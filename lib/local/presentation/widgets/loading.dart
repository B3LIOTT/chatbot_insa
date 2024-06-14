import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:flutter/material.dart';


/// Widget qui affiche un cercle de chargement
///
class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondaryColor),
        ),
      ),
    );
  }
}