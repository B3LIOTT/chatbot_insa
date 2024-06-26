import 'package:flutter/material.dart';

/// Theme de l'application, contient les couleurs principales

class AppTheme {
  static const Color primaryColor = Color(0xFF0D47A1);
  static const Color secondaryColor = Color(0xFFFF816E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFF970F31);
  static const Color txtFieldColor = Color(0xFFE0E0E0);
  static const Color txtFieldContainer = Color(0xFFBDBDBD);

  /// Récupération du theme user pour le [MessageWidget]
  static Map<String, Color> getUserTheme() {
    return {
      'ui': primaryColor,
      'text': black,
    };
  }

  /// Récupération du theme bot pour le [MessageWidget]
  static Map<String, Color> getBotTheme() {
    return {
      'ui': secondaryColor,
      'text': black,
    };
  }
}
