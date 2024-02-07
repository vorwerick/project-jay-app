import 'package:app/application/bloc/events/event_detail_bloc.dart';
import 'package:app/application/cubit/file/file_cubit.dart';
import 'package:app/application/cubit/phone/dial_number_cubit.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/navigation/app_routes.dart';
import 'package:app/presentation/pages/widgets/announcer.dart';
import 'package:app/presentation/pages/widgets/list/list_file_item.dart';
import 'package:app/presentation/pages/widgets/list/list_pair.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventDetailLoadSuccess detail;

  final Widget _divider = const Divider(
    color: Colors.black,
    thickness: 1,
  );

  const EventDetailsScreen({final Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(final BuildContext context) => BlocProvider(
        create: (final context) => FileCubit(),
        child: BlocListener<FileCubit, FileState>(
          listener: (final context, final state) {
            if (state is FileLocalSuccess) {
              context.pushNamed(AppRoutes.pdf.name, pathParameters: {'filePath': state.filePath});
            }
            if (state is FileExternallySuccess) {
              SnackBarUtils.showSuccess(context, state.fileName);
            }
            if (state is FileLoadFailure) {
              SnackBarUtils.showWarning(context, '${AppLocalizations.of(context)!.canNotOpenFile} : ${state.fileName}');
            }
          },
          child: JayContainer(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ListPair(
                        title: AppLocalizations.of(context)!.unit,
                        value: detail.unit,
                        divider: _divider,
                      ),
                      ListPair(
                        title: AppLocalizations.of(context)!.eventType,
                        value: detail.eventType,
                        divider: _divider,
                      ),
                      ListPair(title: AppLocalizations.of(context)!.event, value: detail.event, divider: _divider),
                      ListPair(
                        title: AppLocalizations.of(context)!.technique,
                        value: detail.technique,
                        divider: _divider,
                      ),
                      ListPair(title: AppLocalizations.of(context)!.region, value: detail.region, divider: _divider),
                      ListPair(
                        title: AppLocalizations.of(context)!.municipality,
                        value: detail.municipality,
                        divider: _divider,
                      ),
                      ListPair(title: AppLocalizations.of(context)!.street, value: detail.street, divider: _divider),
                      ListPair(title: AppLocalizations.of(context)!.object, value: detail.object, divider: _divider),
                      ListPair(title: AppLocalizations.of(context)!.floor, value: detail.floor, divider: _divider),
                      ListPair(
                        title: AppLocalizations.of(context)!.explanation,
                        value: detail.explanation,
                        divider: _divider,
                      ),
                      ListPair(
                        title: AppLocalizations.of(context)!.lastUpdate,
                        value: detail.lastUpdate,
                        divider: _divider,
                      ),
                      ListPair(
                        title: AppLocalizations.of(context)!.otherTechnique,
                        value: detail.otherTechnique,
                        divider: _divider,
                      ),
                      Announcer(
                        title: AppLocalizations.of(context)!.notifier,
                        name: detail.notifier,
                        number: detail.notifierNumber,
                        onTap: (final phoneNumber) => DialNumberCubit().dialNumber(phoneNumber),
                      ),
                      Builder(
                        builder: (context) => Column(
                          children: detail.files
                              .map(
                                (final e) => ListFileItem(
                                  filePair: e,
                                  onFileSelected: (final file) => context.read<FileCubit>().openFile(e),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
