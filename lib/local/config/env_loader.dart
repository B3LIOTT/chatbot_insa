import 'package:flutter_dotenv/flutter_dotenv.dart';


class EnvLoader {
  static late String serverUrl;
  static late String socketAddress;
  static late String apiKEY;
  static late String socketUrl;
  static late String receivedMessageEvent;
  static late String sendMessageEvent;
  static late String loadingEvent;
  static late String disconnectEvent;
  static late String rejectMessageEvent;
  static String accessTokenUrl = 'accessTokenApi'; // TODO: a changer


  static Future<void> initEnv() async {
    socketAddress = 'https://fffff';
    apiKEY = 'fffff';
    socketUrl = 'https://fffff';
    receivedMessageEvent = 'fffff';
    sendMessageEvent = 'fffff';
    loadingEvent = 'fffff';
    disconnectEvent = 'fffff';
    rejectMessageEvent = 'fffff';
    serverUrl = 'https://fffff';
/*    await dotenv.load(fileName: ".env");
    serverUrl = dotenv.get('SERVER_URL', fallback: '');
    socketAddress = dotenv.get('SOCKET_ADDRESS', fallback: '');
    apiKEY = dotenv.get('API_KEY', fallback: '');
    socketUrl = dotenv.get('SOCKET_URL', fallback: '');
    receivedMessageEvent = dotenv.get('RECEIVED_MESSAGE_EVENT', fallback: '');
    sendMessageEvent = dotenv.get('SEND_MESSAGE_EVENT', fallback: '');
    loadingEvent = dotenv.get('LOADING_EVENT', fallback: '');*/
  }
}
