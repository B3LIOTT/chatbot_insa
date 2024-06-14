import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:chatbot_insa/local/presentation/providers/messages_state_provider.dart';
import 'package:chatbot_insa/local/presentation/widgets/loading.dart';
import 'package:chatbot_insa/local/storage/local_storage.dart';
import 'package:chatbot_insa/remote/request_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Widget permettant de vérifier la connexion au serveur

class ConnexionCheck extends ConsumerStatefulWidget {
  final ValueChanged<bool> update;

  const ConnexionCheck({required this.update, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConnexionCheckState();
}

class _ConnexionCheckState extends ConsumerState<ConnexionCheck> {
  Widget mainW = const Loading();
  bool _showBtn = false;


  @override
  void initState() {
    _initUserData();
    super.initState();
  }

  /// Widget d'erreur qui affiche un message d'erreur
  Widget errW() {
    return const Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
          child: Center(child: Text("Erreur lors de la connexion au serveur", style: TextStyle(fontSize: 35, color: AppTheme.secondaryColor ), textAlign: TextAlign.center,))),
    );
  }

  /// Fonction permettant de récupérer le token d'accès, puis de l'enregistrer dans les shared preferences.
  /// Puis initialise le socket de connexion
  /// En cas d'erreur, affiche un message d'erreur
  /// En cas de succès, met à jour le parent avec le statut de connexion
  ///
  Future<void> _initUserData() async {
    try {
      LocalStorage.clearAccessToken();

      setState(() {
        mainW = const Loading();
        _showBtn = false;
      });

      final token = await LocalStorage.getAccessToken();
      if(token == "") {
        await getAccessToken();
      }
      if (ref.read(messagesStateProvider.notifier).socket.connected) {
        ref.read(messagesStateProvider.notifier).socket.dispose();
      }
      ref.read(messagesStateProvider.notifier).initSocket();

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      widget.update(false);
      setState(() {
        mainW = errW();
        _showBtn = true;
      });
    }
  }


  /// Bouton permettant de réessayer la connexion
  ///
  Widget btn(double w) {
    return Card(
      elevation: 10,
      color: AppTheme.secondaryColor,
      surfaceTintColor: AppTheme.white,
      shadowColor: AppTheme.black.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
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

  /// Fonction permettant de mettre à jour le parent avec le statut de connexion
  /// Cela permet de mettre à jour l'interface en fonction de la connexion dans la page HomePage
  ///
  void _backPropagateSucess() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.update(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final state = ref.watch(messagesStateProvider);

    // Si la connexion est établie, on met à jour le parent
    if (state.isConnected) {
      _backPropagateSucess();
    }

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