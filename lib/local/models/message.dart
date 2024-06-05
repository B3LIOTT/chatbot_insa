import 'package:chatbot_insa/local/config/exceptions.dart';


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

  Map<String, dynamic> toSocket() {
    return {
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'timestamp': timestamp,
    };
  }
}