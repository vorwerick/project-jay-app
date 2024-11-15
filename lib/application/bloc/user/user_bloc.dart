import 'dart:developer';

import 'package:app/application/extensions/l.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> with L {
  UserBloc() : super(UserInitial()) {
    on<UserStarted>((final event, final emit) async {
      l.i('Getting current user');
      emit(UserLoadInProgress());

      final repository = GetIt.I.get<UserRepository>();

      final result = await repository.getUser();
      if (result.isSuccess) {
        emit(UserLoadSuccess(
            result.success.fullNameWithTitle,
            result.success.id,
            result.success.email,
            result.success.functionName));
      } else {
        l.e('Getting user failure');
        if (result.failure is UserRepositoryBadResponse) {
          final resp = result.failure as UserRepositoryBadResponse;
          emit(UserLoadFailure("HTTP_STATUS_" + resp.value.toString()));
        }
        if (result.failure is UserRepositoryError) {
          final resp = result.failure as UserRepositoryError;
          if (resp.exception is DioException) {
            emit(UserLoadFailure(
                (resp.exception as DioException).message ?? "unknown"));
          } else {
            emit(UserLoadFailure(resp.exception.toString()));
          }
        }
        emit(UserLoadFailure("HTTP_STATUS_"));
      }
    });
  }
}
