import 'package:app/application/bloc/alarms/alarm_control_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/fab/action_button.dart';
import 'package:app/presentation/components/fab/expandable_fab.dart';
import 'package:app/presentation/components/jay_alarm_dialog.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayFabView extends StatefulWidget {
  const JayFabView({super.key});

  @override
  State<JayFabView> createState() => _JayFabViewState();
}

class _JayFabViewState extends State<JayFabView> {
  final ValueNotifier<JayFabEvent> _notifier = ValueNotifier<JayFabEvent>(JayFabEvent.close());

  @override
  Widget build(final BuildContext context) => BlocListener<AlarmControlBloc, AlarmControlState>(
        listener: (final context, final state) {
          switch (state) {
            case AlarmControlOpen():
              _notifier.value = JayFabEvent.open();
              break;
            case AlarmControlAccepted():
              _notifier.value = JayFabEvent.closeWithNewParams(
                Icons.done,
                JayColors.primary,
                "Účast na výjezdu potvrzena",
              );
              break;
            case AlarmControlRejected():
              _notifier.value = JayFabEvent.closeWithNewParams(
                Icons.close,
                JayColors.primary,
                "Účast na výjezdu odmítnuta",
              );
              break;
            case AlarmControlEmpty() || AlarmControlInitial():
              _notifier.value = JayFabEvent.close();
              break;
            case AlarmControlFailed():
              SnackBarUtils.showError(context, 'nepovedlo se');
              _notifier.value = JayFabEvent.close();
              break;
          }
        },
        child: ExpandableFab(
          notifier: _notifier,
          distance: 100, //175
          initialOpen: true,
          children: [
            Container(
              decoration: BoxDecoration(              color: JayColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(24))),
              padding: EdgeInsets.all(24),
              child: Column(children: [
                Row(mainAxisSize: MainAxisSize.max,children: [

                  ActionButton(
                    onPressed: () {
                      // _notifier.value = JayFabEvent.closeWithNewParams(
                      //   Icons.done,
                      //   JayColors.green,
                      //   AppLocalizations.of(context)!.accepted,
                      // );
                      context.read<AlarmControlBloc>().add(
                        AlarmControlAcceptPressed(),
                      );
                    },
                    icon: const Icon(Icons.done, color: JayColors.primary),
                    backgroundColor: JayColors.green,),
                  SizedBox(width: 24,),
                  ActionButton(
                    onPressed: () {
                      // _notifier.value = JayFabEvent.closeWithNewParams(
                      //   Icons.close,
                      //   JayColors.red,
                      //   AppLocalizations.of(context)!.rejected,
                      // );
                      context.read<AlarmControlBloc>().add(
                        AlarmControlRejectPressed(),
                      );
                    },
                    icon: const Icon(Icons.close, color: JayColors.primary),
                    backgroundColor: Colors.red,
                  ),
                  // ActionButton(
                  //   onPressed: () {
                  //     _showAlarmDialog(context);
                  //   },
                  //   icon: const Icon(Icons.circle_outlined),
                  //   backgroundColor: JayColors.orange,
                  // ),

                ],),
                SizedBox(height: 16,),
                Text("Účast na výjezdu", style: Theme.of(context).textTheme.titleLarge,),
              ],)
            )

          ],
        ),
      );

  Future<void> _showAlarmDialog(final BuildContext context) async {
    await showDialog(
      context: context,
      builder: (final BuildContext builderContext) => JayAlarmDialog(
        onAccept: () {
          _notifier.value = JayFabEvent.closeWithNewParams(
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
