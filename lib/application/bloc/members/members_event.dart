part of 'members_bloc.dart';

@immutable
abstract class MembersEvent {}

final class MembersStarted extends MembersEvent {
  final bool enableLiveUpdate;
  final int id;
  MembersStarted({this.enableLiveUpdate = false, required this.id});
}

final class MembersSilentRefresh extends MembersEvent {
  final int id;
  MembersSilentRefresh({ required this.id});
}
