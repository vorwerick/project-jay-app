import 'package:app/domain/primitives/result.dart';

abstract interface class TTSService {
  Future<Result<TTSServiceState, void>> speak(final String text);
}

sealed class TTSServiceState {}

final class TTSDisabled extends TTSServiceState {}

final class TTSServiceError extends TTSServiceState {
  final Exception exception;

  TTSServiceError(this.exception);
}
