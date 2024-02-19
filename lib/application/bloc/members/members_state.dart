part of 'members_bloc.dart';

@immutable
abstract class MembersState {}

class MembersInitial extends MembersState {}

class MembersLoadInProgress extends MembersState {}

class MembersLoadFailure extends MembersState {}

class MembersLoadSuccess extends MembersState {
  final List<MemberDto> members;

  MembersLoadSuccess(this.members);
}
