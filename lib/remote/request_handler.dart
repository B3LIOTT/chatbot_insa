import 'dart:convert';

import 'package:chatbot_insa/local/config/env_loader.dart';
import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:http/http.dart' as http;


Future<void> getAccessToken() async {
  try {
    var res = await http.Client().get(
        Uri.parse(
            '${EnvLoader.serverUrl}/${EnvLoader.accessTokenUrl}'),
        headers: <String, String>{
          'x-api-key': EnvLoader.apiKEY,
        }).timeout(const Duration(seconds: 10),
        onTimeout: () => http.Response("timeout", 408));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      LocalStorage.setAccessToken(json['access_token']);

    } else {
      throw Exception('Status code error: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data');
  }
}