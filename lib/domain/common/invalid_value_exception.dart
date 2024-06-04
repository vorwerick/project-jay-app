final class InvalidValueException implements Exception {
  final String message;

  InvalidValueException(this.message);

  @override
  String toString() => 'InvalidValueException{message: $message}';
}
