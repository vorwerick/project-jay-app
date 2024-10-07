import 'package:app/application/bloc/alarms/active_alarm_bloc.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/widgets/app_bar_alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final int currentPageIndex;

  const CustomAppBar({super.key, required this.currentPageIndex});

  @override
  Widget build(final BuildContext context) => BlocBuilder<ActiveAlarmBloc, ActiveAlarmState>(
        builder: (final context, final state) {
          if (state is ActiveAlarmLoadSuccess) {
            if (state.alarms.isNotEmpty) {
              return AppBar(
                toolbarHeight: 80,
                backgroundColor: JayColors.primary,
                title: AppBarAlarm(
                  eventDetail:
                  state.alarms[currentPageIndex],
                ),
                //bottom: TextToSpeechControlPanel(),
              );
            }
          }
          return AppBar(
            backgroundColor: JayColors.primaryLight,
            title: const Text('Žádný aktivní poplach'),
          );
        });

  @override
  Size get preferredSize => Size.fromHeight(80);
}