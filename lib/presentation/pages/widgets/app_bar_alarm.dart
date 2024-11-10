import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/custom_tab_bar.dart';
import 'package:app/presentation/pages/widgets/tts_control_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AppBarAlarm extends StatefulWidget {
  final AlarmDto eventDetail;
  final CustomTabBar tabBar;
  final bool isActive;

  const AppBarAlarm(
      {super.key, required this.eventDetail, required this.tabBar, required this.isActive});

  @override
  State<AppBarAlarm> createState() => _AppBarAlarmState();
}

class _AppBarAlarmState extends State<AppBarAlarm> {
  PoolingCubit? poolingCubitReference = null;

  @override
  void initState() {
    GetIt.I<TextToSpeechService>().setOnStopListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    poolingCubitReference?.close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext c) => BlocProvider<PoolingCubit>(
        create: (final BuildContext context) {
          poolingCubitReference = PoolingCubit();
          poolingCubitReference!.start(const Duration(milliseconds: 250));
          return poolingCubitReference!;
        },
        child: BlocListener<PoolingCubit, PoolingState>(
            listener: (final BuildContext context, final state) {
              if (state is PoolingFetched) {
                setState(() {});
              }
            },
            child: AppBar(
              backgroundColor: JayColors.primaryLight,
              actions: [

              ],
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.eventDetail.event}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(width: 8,),

                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    TextToSpeechControlPanel(),
                    Card(
                      color: JayColors.secondary,
                      child: Text(
                        "  KOPIS  ",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],)

                ],
              ),
              bottom: widget.tabBar,
            )),
      );
}
