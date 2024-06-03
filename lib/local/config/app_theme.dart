import 'package:flutter/material.dart';


class AppTheme {
  static const Color primaryColor = Color(0xFF0D47A1);
  static const Color secondaryColor = Color(0xFFE6F0FF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color txtFieldColor = Color(0xFFE0E0E0);

  static Map<String, Color> getUserTheme() {
    return {
      'message': secondaryColor,
      'text': black,
    };
  }

  static Map<String, Color> getBotTheme() {
    return {
      'message': primaryColor,
      'text': white,
    };
  }
}