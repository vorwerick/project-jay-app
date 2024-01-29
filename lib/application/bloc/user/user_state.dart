part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [this];
}

final class CurrentUserState extends UserState {
  final String fullName;

  CurrentUserState(this.fullName);

  @override
  List<Object?> get props => [fullName];
}
