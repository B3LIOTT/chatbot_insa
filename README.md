# Talk2Eve

Cette application Flutter à été réalisée dans le cadre d'un projet de ChatBot à l'INSA Haut De France.

## Fonctionnement
- connexion HTTPS au middleware pour demander un access token (avec la clé api contenue dans les variables d'environnement)
- connexion en socket TLS au middleware qui se charge de transmettre les messages client vers les modèles d'IA, et de faire de même pour le retour
- gestion de l'affichage avec riverpod, un provider qui ici permet de mettre à jour l'etat de connexion au serveur, et l'état de la discussion en fonction des évenements sockets
