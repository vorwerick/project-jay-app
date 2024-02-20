import 'package:app/application/bloc/members/members_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/pages/widgets/list/list_pariticipant_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantsScreen extends StatelessWidget {
  ParticipantsScreen({super.key});

  final List<Widget> mockedData = [
    ListParticipantPair(
      badgeColor: JayColors.badgeCheck,
      title: 'Hasic 1',
      subtitle: 'Velitel',
      trailingTime: DateTime.now(),
    ),
    ListParticipantPair(
      badgeColor: JayColors.badgeWarning,
      title: 'Hasic 2',
      subtitle: 'Strojnik',
      trailingTime: DateTime.now(),
    ),
    ListParticipantPair(
      badgeColor: JayColors.badgeMessage,
      title: 'Hasic 3',
      subtitle: 'Hasic',
      trailingTime: DateTime.now(),
    ),
    ListParticipantPair(
      badgeColor: JayColors.badgeCross,
      title: 'Hasic 4',
      subtitle: 'Hasic',
      trailingTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => MembersBloc()..add(MembersStarted()),
        child: BlocBuilder<MembersBloc, MembersState>(
          builder: (final context, final state) {
            if (state is MembersLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MembersLoadSuccess && state.members.isNotEmpty) {
              return ListView.builder(
                itemCount: state.members.length,
                itemBuilder: (final context, final index) => ListParticipantPair(
                  badgeColor: JayColors.badgeCross,
                  title: state.members[index].name,
                  subtitle: state.members[index].function,
                  trailingTime: state.members[index].dateOfAcceptation,
                ),
              );
            }

            return const Center(
              child: JayWhiteText('No members', fontSize: 20.0),
            );
          },
        ),
      );
}
