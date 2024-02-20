import 'dart:async';

mixin RepositoryStreamer<T> {
  final StreamController<T> _streamController = StreamController<T>.broadcast();

  Stream<T> get stream => _streamController.stream;

  void notifyListeners(final T value) {
    _streamController.add(value);
  }
}
