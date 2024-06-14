
/// Exception lorsque le format du message est incorrect

class BadMessageFormatException implements Exception {
  final String message;

  BadMessageFormatException(this.message);
}