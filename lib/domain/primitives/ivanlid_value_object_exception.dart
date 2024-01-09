class InvalidValueObjectException implements Exception {
  final String message;
  final dynamic valueObjectData;

  InvalidValueObjectException(this.message, this.valueObjectData);

  @override
  String toString() {
    // TODO: implement toString
    return 'InvalidValueObjectException: $message, can not created with $valueObjectData';
  }
}
