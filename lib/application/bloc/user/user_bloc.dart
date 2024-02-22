import 'package:app/application/extensions/l.dart';
import 'package:app/domain/user/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
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
        emit(UserLoadSuccess(result.success.fullNameWithTitle));
      } else {
        l.e('Getting user failure');
        emit(UserLoadFailure());
      }
    });
  }
}
