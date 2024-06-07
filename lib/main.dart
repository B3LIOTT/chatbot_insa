import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local/config/env_loader.dart';
import 'local/presentation/pages/home.dart';
//import 'package:flutter_displaymode/flutter_displaymode.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // UI
  await SystemChrome.setPreferredOrientations([ // Permet de bloquer l'orientation
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  //await FlutterDisplayMode.setHighRefreshRate(); // Permet d'aller au dela de 60Hz

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
      title: 'Chat-Bot-INSA',
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
      )
    );
  }
}