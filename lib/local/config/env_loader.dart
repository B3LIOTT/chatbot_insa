import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Variables d'environnement de l'app (en partie stockées dans .env pour les infos sensibles)

class EnvLoader {
  static late String serverUrl;
  static late String socketUrl;
  static late String apiKEY;
  static late String receivedMessageEvent;
  static late String newWordEvent;
  static late String sendMessageEvent;
  static late String loadingEvent;
  static late String disconnectEvent;
  static late String errorEvent;
  static late String accessTokenUrl;


  static Future<void> initEnv() async {
    accessTokenUrl = '/api/request_token';
    receivedMessageEvent = 'message';
    sendMessageEvent = 'message';
    newWordEvent = 'word';
    loadingEvent = 'loading';
    disconnectEvent = 'disconnect';
    errorEvent = 'error';

    await dotenv.load(fileName: ".env");
    serverUrl = dotenv.get('SERVER_URL', fallback: '');
    apiKEY = dotenv.get('API_KEY', fallback: '');
    socketUrl = dotenv.get('SOCKET_URL', fallback: '');
  }
}
