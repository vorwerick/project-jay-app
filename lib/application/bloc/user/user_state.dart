part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

final class UserLoadSuccess extends UserState with EquatableMixin {
  final String fullName;
  final int memberId;

  UserLoadSuccess(this.fullName, this.memberId);

  @override
  List<Object?> get props => [fullName];
}

final class UserLoadInProgress extends UserState {}

final class UserLoadFailure extends UserState {
   final String statusCode;
    UserLoadFailure(this.statusCode);
}
