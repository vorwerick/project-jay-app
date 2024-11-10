import 'dart:developer';

import 'package:app/application/extensions/l.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:app/infrastructure/api_v1/models/json/feedback.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> with L {
  FeedbackBloc() : super(FeedbackInitial()) {
    on<SendFeedback>((final event, final emit) async {
      emit(FeedbackSentInProgress());

      final repository = GetIt.I.get<UserRepository>();

      final result = await repository
          .setFeedback(Feedback(event.email, event.type, event.message));
      if (result.isSuccess) {
        log("SUCESAK");
        emit(FeedbackSentSuccess());
      } else {
        l.e('Getting user failure');
        if (result.failure is UserRepositoryBadResponse) {
          final resp = result.failure as UserRepositoryBadResponse;
          log("HTTP_STATUS_${resp.value}");
          emit(FeedbackSentFailed("HTTP_STATUS_${resp.value}"));
        }
        if (result.failure is UserRepositoryError) {
          final resp = result.failure as UserRepositoryError;
          if (resp.exception is DioException) {
            log("HTTP_STATUS_${(resp.exception as DioException).message}");
            emit(FeedbackSentFailed(
                (resp.exception as DioException).message ?? "unknown"));
          } else {
        log("HTTP_STATUS_"+     resp.exception.toString());
            emit(FeedbackSentFailed(resp.exception.toString()));
          }
        }
      }
    });
  }
}
