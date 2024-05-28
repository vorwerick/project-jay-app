import 'package:app/domain/common/result.dart';
import 'package:app/domain/user/entity/credentials.dart';

abstract interface class CredentialsStorage {
  Future<void> store(final Credentials credentials);

  Future<void> delete();

  Future<void> update(final Credentials credentials);

  Future<Result<CredentialsErrors, Credentials>> get();
}

sealed class CredentialsErrors {}

final class CredentialsNotFound extends CredentialsErrors {}
