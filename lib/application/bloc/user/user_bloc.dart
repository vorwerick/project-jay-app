import 'dart:developer';

import 'package:app/domain/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetCurrentUserEvent>((event, emit) async {
      log('Getting current user', name: 'UserBloc');

      final repository = GetIt.I.get<UserRepository>();

      final result = await repository.getUser();

      if (result.isSuccess) {
        emit(CurrentUserState(result.success.fullNameWithTitle));
      } else {
        emit(UserInitial());
      }
    });
  }
}
