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
      id: int.parse(json['id']),
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
}