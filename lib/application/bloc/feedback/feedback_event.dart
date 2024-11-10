part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackEvent {}

final class SendFeedback extends FeedbackEvent {
  final String email;
  final int type;
  final String message;

  SendFeedback(
      {required this.email, required this.type, required this.message});
}
