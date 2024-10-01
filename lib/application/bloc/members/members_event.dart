part of 'members_bloc.dart';

@immutable
abstract class MembersEvent {}

final class MembersStarted extends MembersEvent {
  final bool enableLiveUpdate;
  MembersStarted({this.enableLiveUpdate = false});
}

final class MembersSilentRefresh extends MembersEvent {

}
