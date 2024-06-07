import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/config/env_loader.dart';
import 'package:chatbot_insa/local/presentation/pages/home.dart';
import 'package:chatbot_insa/local/presentation/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ConnexionCheck extends StatefulWidget {
  const ConnexionCheck({super.key});

  @override
  _ConnexionCheckState createState() => _ConnexionCheckState();
}

class _ConnexionCheckState extends State<ConnexionCheck> {
  Widget mainW = const Loading();
  bool _showBtn = false;

  @override
  void initState() {
    _initUserData();
    super.initState();
  }

  Widget errW() {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: const Center(
          child: Center(child: Text("Erreur lors de la connexion au serveur", style: TextStyle(fontSize: 35, color: AppTheme.secondaryColor ), textAlign: TextAlign.center,))),
    );
  }

  Future<void> _initUserData() async {
    try {
      setState(() {
        mainW = const Loading();
        _showBtn = false;
      });
/*
      var res = await http.Client().get(
          Uri.parse(
              '${EnvLoader.serverUrl}/${EnvLoader.accessTokenUrl}'),
          headers: <String, String>{
            'x-api-key': EnvLoader.apiKEY,
          }).timeout(const Duration(seconds: 10),
          onTimeout: () => http.Response("timeout", 408));

      // recupération des données utilisateur si il y a une connexion internet
      if (res.statusCode == 200) {

      } else {
        ref.watch(userStateProvider.notifier).updateState(const UserConnectionState(
          response: {},
        ));
        setState(() {
          mainW = errW();
          _showBtn = true;
        });
      }
 */
      // TODO: update value ???
    } catch (e) {
      print(e);
    }
  }

  Widget btn(double w) {
    return Card(
      elevation: 18,
      color: AppTheme.secondaryColor,
      surfaceTintColor: AppTheme.white,
      shadowColor: Theme.of(context).shadowColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          HapticFeedback.lightImpact();
          _initUserData();
        },
        child: SizedBox(
            width: w * 0.8,
            height: w * 0.25,
            child: const Center(
                child: Text(
                  "Réessayer",
                  style: TextStyle(
                      fontSize: 35, letterSpacing: 4, color: AppTheme.white),
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        mainW,
        Padding(
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.top),
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutQuint,
              offset: _showBtn ? const Offset(0, 0.85) : const Offset(0, 1.2),
              child: Align(
                alignment: Alignment.topCenter,
                child: btn(w),
              ),
            ))
      ],
    );
  }
}