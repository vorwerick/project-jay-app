import 'package:app/application/cubit/file/file_cubit.dart';
import 'package:app/application/cubit/phone/dial_number_cubit.dart';
import 'package:app/application/dto/alarm_dto.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/pages/widgets/announcer.dart';
import 'package:app/presentation/pages/widgets/list/list_pair.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailsScreen extends StatelessWidget {
  final AlarmDto detail;

  final Widget _divider = const Divider(
    thickness: 1,
  );

  const EventDetailsScreen({super.key, required this.detail});

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => FileCubit(),
        child: BlocListener<FileCubit, FileState>(
          listener: (final context, final state) {
            /*
            if (state is FileLocalSuccess) {
              context.pushNamed(
                AppRoutes.pdf.name,
                pathParameters: {'filePath': state.filePath},
              );
            }

             */
            if (state is FileExternallySuccess) {
              SnackBarUtils.showSuccess(context, state.fileName);
            }
            if (state is FileLoadFailure) {
              SnackBarUtils.showWarning(
                context,
                '${AppLocalizations.of(context)!.canNotOpenFile} : ${state.fileName}',
              );
            }
          },
          child: JayContainer(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 12,
                      interactive: true,
                      radius: Radius.circular(32),
                      child: ListView(
                        children: [
                          ListPair(
                            title: AppLocalizations.of(context)!.unit,
                            value: detail.unit,
                            background: Colors.transparent,                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.eventType,
                            value: detail.eventType,
                            background: JayColors.secondaryLight,
                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.event,
                            value: detail.event,
                            background: Colors.transparent,                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.technique,
                            value: detail.technique
                                ?.map((final t) => t.fleetName)
                                .join(', '),
                            background: JayColors.secondaryLight,
                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.region,
                            value: detail.region,
                            background: Colors.transparent,
                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.municipality,
                            value: detail.municipality,
                            background: JayColors.secondaryLight,
                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.street,
                            value:
                                '${detail.street} ${detail.num1 != null ? (detail.num2 != null ? ('${detail.num1!}/${detail.num2!}') : detail.num1!) : ''}',
                            background: Colors.transparent,                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.object,
                            value: detail.object,
                            background: JayColors.secondaryLight,
                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.floor,
                            value: detail.floor,
                            background: Colors.transparent,                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.explanation,
                            value: detail.explanation,
                            background: JayColors.secondaryLight,
                          ),
                          ListPair(
                            title: 'Upřesnění',
                            value: detail.clarification,
                            background: Colors.transparent,
                          ),
                          ListPair(
                            title: AppLocalizations.of(context)!.lastUpdate,
                            value: detail.lastUpdate,
                            background: JayColors.secondaryLight,                          ),
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
                            number: 'tel: ${detail.notifierNumber}',
                            background: JayColors.secondaryLight,                            icon: Icon(
                              color: Colors.white,
                              Icons.phone,
                            ),
                            onTap: (final phoneNumber) =>
                                DialNumberCubit().dialNumber(phoneNumber),
                          ),
                          //_documentsWidget(),
                          ListPair(
                            title: '\n\n\n\n\n\n\n\n\n\n\n',
                            value: '',
                            background: Colors.transparent,                          ),
                          SizedBox(
                            height: 72,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _documentsWidget() => Builder(
        builder: (final context) => Column(
          children: detail.files
              .map(
                (final e) => ListPairAction(
                  onTap: (final filepath) {
                    context.read<FileCubit>().openFile(e);
                  },
                  icon: Icon(
                    color: Colors.white,
                    Icons.file_present_rounded,
                  ),
                  name: e.path,
                  number: '',
                  title: 'Dokument',
                  background: detail.files.indexOf(e) % 2 == 0
                      ? JayColors.secondaryLight
                      : JayColors.primaryLight,
                ),
              )
              .toList(),
        ),
      );
}
