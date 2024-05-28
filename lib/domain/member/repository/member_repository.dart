import 'package:app/domain/common/result.dart';
import 'package:app/domain/member/entity/member.dart';

abstract interface class MemberRepository {
  Future<Result<MemberRepositoryState, List<Member>>> getMembersById(final int id);
}

sealed class MemberRepositoryState {}

final class MemberRepositoryFailure extends MemberRepositoryState {
  final Exception exception;

  MemberRepositoryFailure(this.exception);
}
