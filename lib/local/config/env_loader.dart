import 'package:flutter_dotenv/flutter_dotenv.dart';


class EnvLoader {
  static late String serverUrl;

  static Future<void> initEnv() async {
    await dotenv.load(fileName: ".env");
  }
}
