import 'dart:async';
import 'dart:developer';

import 'package:app/application/bloc/members/members_bloc.dart';
import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/list/list_pariticipant_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantsScreen extends StatefulWidget {
  final AlarmDto detail;
  final bool isHistory;

  const ParticipantsScreen(
      {super.key, required this.detail, required this.isHistory});

  @override
  State<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  PoolingCubit? poolingCubitReference = null;
  final List<Widget> mockedData = [
    ListParticipantPair(
      badgeColor: JayColors.badgeCheck,
      title: 'Hasic 1',
      subtitle: 'Velitel',
      confirmed: true,
      trailingTime: DateTime.now(),
    ),
    ListParticipantPair(
      badgeColor: JayColors.badgeWarning,
      title: 'Hasic 2',
      subtitle: 'Strojnik',
      trailingTime: DateTime.now(),
      confirmed: true,
    ),
    ListParticipantPair(
      badgeColor: JayColors.badgeMessage,
      title: 'Hasic 3',
      subtitle: 'Hasic',
      confirmed: true,
      trailingTime: DateTime.now(),
    ),
    ListParticipantPair(
      badgeColor: JayColors.badgeCross,
      title: 'Hasic 4',
      confirmed: false,
      subtitle: 'Hasic',
      trailingTime: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    log("PARTI DISPOSED");
    poolingCubitReference?.close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (final context) {
            poolingCubitReference = PoolingCubit();
            poolingCubitReference!.start(const Duration(milliseconds: 2500));
            return poolingCubitReference!;
          }),
          BlocProvider(
              create: (final context) => MembersBloc()
                ..add(
                  MembersStarted(
                    enableLiveUpdate: true,
                    id: widget.detail.eventId,
                  ),
                )),
        ],
        child: BlocListener<PoolingCubit, PoolingState>(
          listener: (final BuildContext context, final state) {
            log("IS HISTORY: " + widget.isHistory.toString());
            if (widget.isHistory) {
              return;
            }
            if (state is PoolingFetched) {
              context
                  .read<MembersBloc>()
                  .add(MembersSilentRefresh(id: widget.detail.eventId));
            }
          },
          child: BlocBuilder<MembersBloc, MembersState>(
            builder: (final context, final state) {
              if (state is MembersLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MembersLoadSuccess) {
                return RefreshIndicator(
                  onRefresh: () {
                    context
                        .read<MembersBloc>()
                        .add(MembersStarted(id: widget.detail.eventId));
                    return Future.value();
                  },
                  child: state.members.isNotEmpty
                      ? ListView.separated(
                          itemCount: state.members.length,
                          itemBuilder: (final context, final index) =>
                              ListParticipantPair(
                            badgeColor: JayColors.badgeCross,
                            title:
                                "${state.members[index].name} ${state.members[index].surname}",
                            subtitle: state.members[index].function,
                            confirmed: state.members[index].confirmed,
                            trailingTime:
                                state.members[index].dateOfAcceptation,
                          ),
                          separatorBuilder:
                              (final BuildContext context, final int index) =>
                                  const Divider(),
                        )
                      : const Center(
                          child: JayWhiteText('Žádní účastníci výjezdu',
                              fontSize: 20.0),
                        ),
                );
              }
              if (state is MembersLoadFailure) {
                return const Center(
                  child: Text("Něco se pokazilo"),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );
}
