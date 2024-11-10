part of 'feedback_bloc.dart';

@immutable
abstract class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackSentInProgress extends FeedbackState {}

final class FeedbackSentSuccess extends FeedbackState {}

final class FeedbackSentFailed extends FeedbackState {
  final String statusCode;

  FeedbackSentFailed(this.statusCode);
}
