import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local/config/env_loader.dart';
import 'local/presentation/pages/home.dart';
import 'dart:io';
//import 'package:flutter_displaymode/flutter_displaymode.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // UI
  await SystemChrome.setPreferredOrientations([ // Permet de bloquer l'orientation
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  //await FlutterDisplayMode.setHighRefreshRate(); // Permet d'aller au dela de 60Hz

  // Appliquer les HttpOverrides pour accepter les certificats auto-signés
  HttpOverrides.global = MyHttpOverrides();

  // initialisation des variables d'envoronnement
  EnvLoader.initEnv();

  // initialisation des shared preferences
  await LocalStorage.initPrefs();

  runApp(const ProviderScope(
      child: App()
  ));
}

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talk2Eve',
      home: const HomePage(),
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      )
    );
  }
}