import 'package:chatbot_insa/local/config/exceptions.dart';

// Objet Message représentant les messages affichés dans la zone de chat

class Message {
  final int id;
  final bool hasError;
  final String message;
  final String sender;
  final String receiver;
  final String timestamp;

  Message({
    required this.id,
    this.hasError = false,
    required this.message,
    required this.sender,
    required this.receiver,
    required this.timestamp,
  });

  // Constructeur de Message à partir d'un json (venant du socket)
  factory Message.fromJson(Map<String, dynamic> json) {
    try {
      return Message(
        id: json['id'] as int,
        hasError: json['hasError'],
        message: json['message'],
        sender: json['sender'],
        receiver: json['receiver'],
        timestamp: json['timestamp'],
      );
    } catch (e) {
      throw BadMessageFormatException("Impossible de récuperer le message");
    }
  }

  // Convertion en json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hasError': hasError,
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timestamp': timestamp,
    };
  }

  // Convertion en json spécifique pour le socket
  Map<String, dynamic> toSocket() {
    return {
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timestamp': timestamp,
    };
  }
}
