import 'package:app/domain/entities/credentials.dart';
import 'package:app/domain/primitives/either.dart';

abstract interface class CredentialsStorage {
  Future<void> store(Credentials credentials);

  Future<void> delete();

  Future<void> update(Credentials credentials);

  Future<Either<CredentialsErrors, Credentials>> get();
}

sealed class CredentialsErrors {}

final class CredentialsNotFound extends CredentialsErrors {}
