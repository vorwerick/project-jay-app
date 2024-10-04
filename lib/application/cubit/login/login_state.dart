part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class NotLogged extends LoginState {}

final class LoggedIn extends LoginState {}
