import 'package:app/application/bloc/alarms/alarm_control_bloc.dart';
import 'package:app/application/bloc/alarms/alarm_set_control_bloc.dart';
import 'package:app/application/cubit/alarm/alarm_minimize_cubit.dart';
import 'package:app/presentation/common/jay_colors.dart';

import 'package:app/presentation/components/jay_alarm_dialog.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JayFabView extends StatefulWidget {
  final int eventId;
  final int memberId;

  const JayFabView({super.key, required this.eventId, required this.memberId});

  @override
  State<JayFabView> createState() => _JayFabViewState();
}

class _JayFabViewState extends State<JayFabView> {
  bool? accepted = null;

  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<AlarmControlBloc, AlarmControlState>(
        builder: (final context, final AlarmControlState state) {
          if (state is AlarmControlStateLoading) {
            return const CircularProgressIndicator();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state is AlarmControlStateSuccessRejected)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: JayColors.primary, width: 2),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Účast odmítnuta',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<AlarmControlBloc>()
                              .add(AlarmControlEdit());
                        },
                        icon: Icon(Icons.arrow_drop_up,size: 42,),
                      ),
                    ],
                  ),
                ),
              if (state is AlarmControlStateSuccessAccepted)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: JayColors.primary, width: 2),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Účast potvrzena',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<AlarmControlBloc>()
                              .add(AlarmControlEdit());
                        },
                        icon: Icon(
                          Icons.arrow_drop_up,
                            size: 42,
                        ),
                      ),
                    ],
                  ),
                ),
              if(state is AlarmControlStateSuccessNoneMinimized)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(color: JayColors.primary, width: 2),
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Odpověď na výjezd?',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<AlarmControlBloc>()
                              .add(AlarmControlEdit());
                        },
                        icon: Icon(
                          Icons.arrow_drop_up,
                          size: 42,
                        ),
                      ),
                    ],
                  ),
                ),
              if (state is AlarmControlStateSuccessNoneMaximized)
                BlocProvider(
                  create: (final context) =>
                      AlarmSetControlBloc()..add(AlarmSetControlIdle()),
                  child: BlocBuilder<AlarmSetControlBloc, AlarmSetControlState>(
                    builder: (final context, final state) {
                      if (state is AlarmControlStateFailed) {
                        SnackBarUtils.showError(
                          context,
                          "Nezle odpovědět, zkontrolujte připojení.",
                        );
                      }
                      if (state is AlarmSetControlProcessing) {
                        return CircularProgressIndicator();
                      }
                      if (state is AlarmSetControlSuccess) {
                        context.read<AlarmControlBloc>().add(
                              AlarmControlGetStateStarted(
                                eventId: widget.eventId,
                                memberId: widget.memberId,
                              ),
                            );
                        return CircularProgressIndicator();
                      }
                      if (state is AlarmSetControlSkip) {
                        context.read<AlarmControlBloc>().add(
                            AlarmControlMinimize()
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          border:
                              Border.all(color: JayColors.primary, width: 2),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Odpoveď na výjezd',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<AlarmSetControlBloc>().add(
                                          AlarmSetControlMinimizePressed(),
                                        );
                                  },
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    size: 42,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FloatingActionButton.extended(
                              heroTag: const Key('decline'),
                              label: const Text(
                                'Nejdu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                              onPressed: () {
                                context.read<AlarmSetControlBloc>().add(
                                      AlarmSetControlRejectPressed(
                                        eventId: widget.eventId,
                                      ),
                                    );
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 32,
                              ),
                              backgroundColor: Colors.red,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FloatingActionButton.extended(
                              heroTag: const Key('accept'),
                              onPressed: () {
                                context.read<AlarmSetControlBloc>().add(
                                      AlarmSetControlAcceptPressed(
                                        eventId: widget.eventId,
                                      ),
                                    );
                              },
                              icon: const Icon(
                                Icons.directions_run,
                                color: Colors.white,
                                size: 32,
                              ),
                              backgroundColor: JayColors.green,
                              label: const Text(
                                '    Jdu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      );

  Future<void> _showAlarmDialog(final BuildContext context) async {
    await showDialog(
      context: context,
      builder: (final BuildContext builderContext) => JayAlarmDialog(
        onAccept: () {},
      ),
    );
  }
}
