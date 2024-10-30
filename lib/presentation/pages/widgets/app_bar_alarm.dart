import 'dart:async';

import 'package:app/application/cubit/pooling/pooling_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/infrastructure/services/text_to_speech_service.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/widgets/tts_control_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/web.dart';

class AppBarAlarm extends StatefulWidget {
  final AlarmDto eventDetail;

  const AppBarAlarm({super.key, required this.eventDetail});

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
            if(state is PoolingFetched){
              setState(() {});
            }

          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'POPLACH!   ${(DateFormat("mm:ss").format(DateTime(0).add(Duration(milliseconds: DateTime.now().millisecondsSinceEpoch - widget.eventDetail.orderSentTimestamp))))}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 6,),
                  Container(
                    color: JayColors.secondary,
                    child: Text(
                      " KOPIS ",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: JayColors.primary),
                    ),
                  ),
                ],
              ),
              Text(
                '${widget.eventDetail.event} - ${widget.eventDetail.unit}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),

              TextToSpeechControlPanel(),
            ],
          ),
        ),
      );
}
