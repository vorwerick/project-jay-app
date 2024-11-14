import 'dart:async';
import 'dart:developer';

import 'package:app/application/bloc/members/members_bloc.dart';
import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/application/dto/member_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/group_complete.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/pages/widgets/list/list_pariticipant_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantsScreen extends StatefulWidget {
  final AlarmDto detail;
  final bool isHistory;

  const ParticipantsScreen({
    super.key,
    required this.detail,
    required this.isHistory,
  });

  @override
  State<ParticipantsScreen> createState() => _ParticipantsScreenState();
}

class _ParticipantsScreenState extends State<ParticipantsScreen> {
  PoolingCubit? poolingCubitReference = null;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    log('PARTI DISPOSED');
    poolingCubitReference?.close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (final context) {
              poolingCubitReference = PoolingCubit();
              poolingCubitReference!.start(const Duration(milliseconds: 2500));
              return poolingCubitReference!;
            },
          ),
          BlocProvider(
            create: (final context) => MembersBloc()
              ..add(
                MembersStarted(
                  enableLiveUpdate: true,
                  id: widget.detail.eventId,
                ),
              ),
          ),
        ],
        child: BlocListener<PoolingCubit, PoolingState>(
          listener: (final BuildContext context, final state) {
            log('IS HISTORY: ${widget.isHistory}');
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
                return const JayProgressIndicator(text: "Stahuji účast");
              }
              if (state is MembersLoadSuccess) {
                final acceptedMembers = state.members
                    .where(
                      (final e) => e.confirmed,
                    )
                    .toList();

                final rejectedMembers = state.members
                    .where(
                      (final e) => !e.confirmed,
                    )
                    .toList();
                acceptedMembers.sort((a, b) {
                  if (a.memberFunctionType == 0) {
                    return 1;
                  }
                  if (b.memberFunctionType == 0) {
                    return 1;
                  }
                  return a.memberFunctionType.compareTo(b.memberFunctionType);
                });
                return RefreshIndicator(
                  onRefresh: () {
                    context
                        .read<MembersBloc>()
                        .add(MembersStarted(id: widget.detail.eventId));
                    return Future.value();
                  },
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _separatorWithIndicator(
                          'Účastní se (' +
                              acceptedMembers.length.toString() +
                              ")",
                          acceptedMembers),
                      if (acceptedMembers.isNotEmpty)
                        ...acceptedMembers.map(
                          (final member) {
                            log("TYPOS:" +
                                member.memberFunctionType.toString());
                            final isPoliceman = member.function
                                .toLowerCase()
                                .contains("policie");
                            return ListParticipantPair(
                              badgeColor: isPoliceman
                                  ? JayColors.blue
                                  : JayColors.green,
                              title: '${member.name} ${member.surname}',
                              subtitle: member.function,
                              trailingTime: member.dateOfAcceptation,
                              confirmed: member.confirmed,
                              isLast: acceptedMembers.indexOf(member) ==
                                  acceptedMembers.length - 1,
                              icon: isPoliceman
                                  ? Icons.local_police
                                  : Icons.check,
                            );
                          },
                        ),
                      _separator('Odmítli (' +
                          rejectedMembers.length.toString() +
                          ")"),
                      if (rejectedMembers.isNotEmpty)
                        ...rejectedMembers.map(
                          (final member) {
                            final isPoliceman =
                                member.function.contains("policie");
                            return ListParticipantPair(
                              badgeColor:
                                  isPoliceman ? JayColors.blue : JayColors.red,
                              title: '${member.name} ${member.surname}',
                              subtitle: member.function,
                              trailingTime: member.dateOfAcceptation,
                              confirmed: member.confirmed,
                              isLast: acceptedMembers.indexOf(member) ==
                                  acceptedMembers.length - 1,
                              icon: isPoliceman
                                  ? Icons.local_police
                                  : Icons.close,
                            );
                          },
                        ),
                    ],
                  ),
                );
              }
              if (state is MembersLoadFailure) {
                return const Center(
                  child: Text('Něco se pokazilo'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      );

  Widget _separator(final String title) => Container(
        margin: const EdgeInsets.all(12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  Widget _separatorWithIndicator(
          final String title, final List<MemberDto> acceptedList) =>
      Container(
        margin: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            GroupComplete(
              acceptedMember: acceptedList,
            ),
          ],
        ),
      );
}
