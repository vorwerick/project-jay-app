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

  AlarmControlState state = AlarmControlEmpty();

  @override
  Widget build(final BuildContext context) =>
      BlocListener<AlarmControlBloc, AlarmControlState>(
          listener: (final context, final AlarmControlState state) {


            setState(() {
              this.state = state;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state is AlarmControlEmpty) SizedBox.shrink(),

              if(state is AlarmControlRejected)
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: JayColors.primary, width: 2)),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Účast odmítnuta",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    )),
              if(state is AlarmControlAccepted)
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: JayColors.primary, width: 2)),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Účast potvrzena",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    )),
              if (state is AlarmControlOpen || state is AlarmControlInitial)
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border: Border.all(color: JayColors.primary, width: 2)),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Odpoveď na výjezd",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FloatingActionButton.extended(
                          label: Text(
                            "Nejdu",
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
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
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 32,
                          ),
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {

                            context.read<AlarmControlBloc>().add(
                                  AlarmControlAcceptPressed(),
                                );
                          },
                          icon: const Icon(
                            Icons.directions_run,
                            color: Colors.white,
                            size: 32,
                          ),
                          backgroundColor: JayColors.green,
                          label: Text(
                            "    Jdu",
                            style: TextStyle(color: Colors.white, fontSize: 26),
                          ),
                        ),
                      ],
                    ))
            ],
          ));

  Future<void> _showAlarmDialog(final BuildContext context) async {
    await showDialog(
      context: context,
      builder: (final BuildContext builderContext) => JayAlarmDialog(
        onAccept: () {

        },
      ),
    );
  }
}
