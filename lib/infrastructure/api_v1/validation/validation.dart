abstract class Validation<T> {
  T data;

  Validation(this.data);

  bool get isValid;

  bool get isNotValid => !isValid;
}
