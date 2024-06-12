import 'package:flutter_dotenv/flutter_dotenv.dart';


class EnvLoader {
  static late String serverUrl;
  static late String socketAddress;
  static late String apiKEY;
  static late String socketUrl;
  static late String receivedMessageEvent;
  static late String newWordEvent;
  static late String sendMessageEvent;
  static late String loadingEvent;
  static late String disconnectEvent;
  static late String errorEvent;
  static String accessTokenUrl = '/api/request_token';


  static Future<void> initEnv() async {
    apiKEY = 'UwHtq7SkGS51u9DvKEAGM6e2E2izoCYTrgBeVNql1rpsWyfRkxSGx44q7C6YEdiiyOPR4HwFT8N9D0h7eq4HfhRx0x0LlvhP3Ps1B9ra7EfWwYUy8DkWOFwusZQFbIv2';
    socketAddress = 'https://fbxeliott.freeboxos.fr:44444';
    receivedMessageEvent = 'message';
    sendMessageEvent = 'message';
    newWordEvent = 'word';
    loadingEvent = 'loading';
    disconnectEvent = 'disconnect';
    errorEvent = 'error';
    serverUrl = 'https://fbxeliott.freeboxos.fr:44444';
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
