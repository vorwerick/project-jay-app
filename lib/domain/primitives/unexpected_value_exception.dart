final class UnexpectedValueException implements Exception {
  final String message;

  UnexpectedValueException(this.message);

  @override
  String toString() => 'UnexpectedValueException{message: $message}';
}
