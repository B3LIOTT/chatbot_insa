import 'dart:convert';
import 'package:chatbot_insa/local/models/message.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalStorage {
  static late SharedPreferences prefs;
  static const sercurePrefs = FlutterSecureStorage();

  static Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Messages --------------------------------------
  static void setMessages(List<Message> messages) {
    List<String> strMessages = messages.map((e) => jsonEncode(e)).toList();
    prefs.setStringList('messages', strMessages);
  }
  static List<Message> getMessages() {
    final jsons = prefs.getStringList('messages') ?? [];
    return jsons.map((e) {
      try {
        return Message.fromJson(jsonDecode(e));
      } catch (e) {
        return Message(
          id: 0,
          message: "Impossible de récuperer le message",
          sender: "user",
          receiver: "bot",
          hasError: true,
          timestamp: DateTime.now().toIso8601String(),
        );
      }
    }).toList();
  }
  // -------------------------------------------


  // Token --------------------------------------
  static Future<void> setAccessToken(String token) async {
    await sercurePrefs.write(key: 'access_token', value: token);
  }
  static Future<String> getAccessToken() async {
    return await sercurePrefs.read(key: 'access_token') ?? '';
  }
  // -------------------------------------------

}