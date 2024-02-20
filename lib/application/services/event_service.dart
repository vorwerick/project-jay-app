abstract interface class EventService {
  Stream<bool> get stream;

  Future<void> startPolling();

  void stopPolling();

  void dispose();
}
