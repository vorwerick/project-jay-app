import 'package:app/application/dto/mappers/member_mapper.dart';
import 'package:app/application/dto/member_dto.dart';
import 'package:app/domain/alarm/repository/alarm_repository.dart';
import 'package:app/domain/member/repository/member_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'members_event.dart';
part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  MembersBloc() : super(MembersInitial()) {
    on<MembersStarted>((final event, final emit) async {
      emit(MembersLoadInProgress());
      final alarmRepository = GetIt.I<AlarmRepository>();

      final result = await alarmRepository.getLast();

      if (result.isFailure) {
        emit(MembersLoadFailure());
        return;
      }

      final alarmId = result.success.id;

      final memberRepository = GetIt.I<MemberRepository>();

      final membersResult = await memberRepository.getMembersById(alarmId);

      if (membersResult.isFailure) {
        emit(MembersLoadFailure());
        return;
      }

      final List<MemberDto> members = membersResult.success.map((e) => MemberMapper(e).toMemberDto()).toList();

      emit(MembersLoadSuccess(members));
    });
  }
}
