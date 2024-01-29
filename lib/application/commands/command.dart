abstract interface class Command<T> {
  T execute();
}

abstract interface class AsyncCommand<T> extends Command<Future<T>> {
  @override
  Future<T> execute();
}
