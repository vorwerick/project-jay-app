import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/screens/widgets/list_pariticipant_pair.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockedData.length,
      //TODO(Vojjta): Replace mocked data with real data and with ListParticipantPair
      itemBuilder: (context, index) {
        return mockedData[index];
      },
    );
  }
}
