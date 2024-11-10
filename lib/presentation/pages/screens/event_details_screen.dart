import 'dart:developer';

import 'package:app/application/bloc/alarms/alarm_detail_bloc.dart';
import 'package:app/application/cubit/file/file_cubit.dart';
import 'package:app/application/cubit/phone/dial_number_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/components/jay_progress_indicator.dart';
import 'package:app/presentation/pages/widgets/announcer.dart';
import 'package:app/presentation/pages/widgets/list/list_pair.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailsScreen extends StatelessWidget {
  final AlarmDto alarmDto;

  final Widget _divider = const Divider(
    thickness: 1,
  );

  const EventDetailsScreen({super.key, required this.alarmDto});

  @override
  Widget build(final BuildContext context) => BlocProvider(
      create: (final context) => AlarmDetailBloc()
        ..add(
          AlarmDetailIdPressed(alarmDto.eventId),
        ),
      child: Scaffold(body: BlocBuilder<AlarmDetailBloc, AlarmDetailState>(
          builder: (final c, final state) {
        if (state is AlarmDetailLoadSuccess) {
          return _content(context,state.alarm);
        }

        return const JayProgressIndicator(text: 'Stahuji detail události');
      })));

  Widget _content(final context,detail) => JayContainer(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 12,
                interactive: true,
                radius: const Radius.circular(32),
                child: ListView(
                  children: [
                    ListPair(
                      title: AppLocalizations.of(context)!.unit,
                      value: detail.unit,
                      background: Colors.transparent,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.eventType,
                      value: detail.eventType,
                      background: JayColors.secondaryLightest,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.event,
                      value: detail.event,
                      background: Colors.transparent,
                    ),
                    ListPair(
                      title: "Co se stalo",
                      value: detail.explanation,
                      background: JayColors.secondaryLightest,
                    ),
                    ListPair(
                      title: 'Dopřesnění',
                      value: detail.clarification,
                      background: Colors.transparent,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.technique,
                      value: detail.technique
                          ?.map((final t) => t.fleetName)
                          .join(', '),
                      background:  JayColors.secondaryLightest,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.region,
                      value: detail.region,
                      background: Colors.transparent,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.municipality,
                      value: detail.municipality,
                      background: JayColors.secondaryLightest,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.street,
                      value:
                          '${detail.street} ${detail.num1 != null ? (detail.num2 != null ? ('${detail.num1!}/${detail.num2!}') : detail.num1!) : ''}',
                      background: Colors.transparent,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.object,
                      value: detail.object,
                      background: JayColors.secondaryLightest,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.floor,
                      value: detail.floor,
                      background: Colors.transparent,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.lastUpdate,
                      value: detail.lastUpdate,
                      background: JayColors.secondaryLightest,
                    ),
                    ListPair(
                      title: AppLocalizations.of(context)!.otherTechnique,
                      value: detail.otherTechnique
                          ?.map((final t) => t.fleetName)
                          .join(', '),
                      background: Colors.transparent,
                    ),
                    ListPairAction(
                      title: AppLocalizations.of(context)!.notifier,
                      name: detail.notifier,
                      number: '${detail.notifierNumber}',
                      background: JayColors.secondaryLightest,
                      icon: const Icon(
                        color: Colors.white,
                        Icons.phone,
                      ),
                      onTap: (final phoneNumber) {
                        log("NUMBERO: " + phoneNumber);
                        DialNumberCubit().dialNumber(phoneNumber,"+420");
                      }
                    ),
                    //_documentsWidget(),

                    const SizedBox(
                      height: 128,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );


}
