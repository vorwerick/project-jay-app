import 'package:app/domain/common/result.dart';
import 'package:app/domain/user/entity/credentials.dart';
import 'package:app/domain/user/repository/credential_storage.dart';

// TODO(Vojjta): implement https://pub.dev/packages/flutter_secure_storage
final class CredentialsSecureStorage implements CredentialsStorage {
  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result<CredentialsErrors, Credentials>> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<void> store(Credentials credentials) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future<void> update(Credentials credentials) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
