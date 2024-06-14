import 'dart:convert';

import 'package:chatbot_insa/local/config/env_loader.dart';
import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:http/http.dart' as http;


/// Réquête pour obtenir un token d'accès
///
Future<void> getAccessToken() async {
    var res = await http.Client().post(
        Uri.parse(
            '${EnvLoader.serverUrl}/${EnvLoader.accessTokenUrl}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'API_KEY': EnvLoader.apiKEY,
        })).timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response("timeout", 408));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      LocalStorage.setAccessToken(json['access_token']);

    } else {
      throw Exception('Status code error: ${res.statusCode}');
    }
}