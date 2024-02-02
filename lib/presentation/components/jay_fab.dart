import 'package:app/application/bloc/alarms/alarm_control_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/fab/action_button.dart';
import 'package:app/presentation/components/fab/expandable_fab.dart';
import 'package:app/presentation/components/jay_alarm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayFab extends StatefulWidget {
  const JayFab({super.key});

  @override
  State<JayFab> createState() => _JayFabState();
}

class _JayFabState extends State<JayFab> {
  ValueNotifier<JayFabEvent> notifier = ValueNotifier<JayFabEvent>(JayFabEvent.open());

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (context) => AlarmControlBloc(),
        child: Builder(
          builder: (builderContext) => ExpandableFab(
            notifier: notifier,
            distance: 175,
            initialOpen: true,
            children: [
              ActionButton(
                onPressed: () {
                  notifier.value = JayFabEvent.closeWithNewParams(
                    Icons.close,
                    JayColors.red,
                    AppLocalizations.of(context)!.rejected,
                  );
                  builderContext.read<AlarmControlBloc>().add(
                        AlarmControlRejectPressed(),
                      );
                },
                icon: const Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
              ActionButton(
                onPressed: () {
                  _showAlarmDialog(builderContext);
                },
                icon: const Icon(Icons.circle_outlined),
                backgroundColor: JayColors.orange,
              ),
              ActionButton(
                onPressed: () {
                  notifier.value = JayFabEvent.closeWithNewParams(
                    Icons.done,
                    JayColors.green,
                    AppLocalizations.of(context)!.accepted,
                  );
                  builderContext.read<AlarmControlBloc>().add(
                        AlarmControlAcceptPressed(),
                      );
                },
                icon: const Icon(Icons.done),
                backgroundColor: JayColors.green,
              ),
            ],
          ),
        ),
      );

  Future<void> _showAlarmDialog(final BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext builderContext) => JayAlarmDialog(
        onAccept: () {
          notifier.value = JayFabEvent.closeWithNewParams(
            Icons.circle_outlined,
            JayColors.orange,
            AppLocalizations.of(context)!.delayed,
          );
          context.read<AlarmControlBloc>().add(
                AlarmControlDelayPressed(),
              );
        },
      ),
    );
  }
}
