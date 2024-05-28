base class Entity {
  static const int emptyId = -1;
  final int id;

  Entity(this.id);

  Entity.empty() : id = emptyId;

  bool get isEmpty => id == -1;

  bool get isNotEmpty => !isEmpty;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(final Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is Entity && other.id == id;
  }
}
