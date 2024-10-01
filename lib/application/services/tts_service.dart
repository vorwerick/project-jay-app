import 'package:app/domain/common/result.dart';

abstract interface class TTSService {
  Future<Result<TTSServiceState, void>> start();
}

sealed class TTSServiceState {}

final class TTSDisabled extends TTSServiceState {}

final class TTSServiceError extends TTSServiceState {
  final Exception exception;

  TTSServiceError(this.exception);
}
