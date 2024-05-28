part of 'repository_state.dart';

/// Remote statuses entry point class
sealed class RemoteRepositoryState extends RepositoryState {
  RemoteRepositoryState();

  factory RemoteRepositoryState.failure(final Exception exception) => RemoteFailure(exception);

  factory RemoteRepositoryState.notFound() => NotFoundRemotely();

  factory RemoteRepositoryState.invalidResponse(final String message) => InvalidResponse(message);
}

final class NotFoundRemotely extends RemoteRepositoryState {}

final class InvalidResponse extends RemoteRepositoryState {
  final String message;

  InvalidResponse(this.message);

  @override
  toString() => 'InvalidResponse: $message';
}

final class RemoteFailure extends RemoteRepositoryState {
  final Exception exception;

  RemoteFailure(this.exception);

  @override
  toString() => 'RemoteFailure: $exception';
}
