part of 'dial_number_cubit.dart';

@immutable
abstract class DialNumberState extends Equatable {}

class DialNumberInitial extends DialNumberState {
  @override
  List<Object?> get props => [this];
}

final class DialNumberFailed extends DialNumberState {
  final String number;

  DialNumberFailed({
    required this.number,
  });

  @override
  List<Object?> get props => [number];

  @override
  bool? get stringify => true;
}
