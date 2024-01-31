import 'package:app/application/bloc/events/event_detail_bloc.dart';
import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/pages/widgets/list_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetailsScreen extends StatelessWidget {
  final LoadedDetailState detail;

  final Widget _divider = const Divider(
    color: Colors.black,
    thickness: 1,
  );

  const EventDetailsScreen({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) => JayContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListPair(
                title: AppLocalizations.of(context)!.unit,
                value: detail.unit,
                divider: _divider,
              ),
              ListPair(title: AppLocalizations.of(context)!.eventType, value: detail.eventType, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.event, value: detail.event, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.technique, value: detail.technique, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.region, value: detail.region, divider: _divider),
              ListPair(
                title: AppLocalizations.of(context)!.municipality,
                value: detail.municipality,
                divider: _divider,
              ),
              ListPair(title: AppLocalizations.of(context)!.street, value: detail.street, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.object, value: detail.object, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.floor, value: detail.floor, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.explanation, value: detail.explanation, divider: _divider),
              ListPair(title: AppLocalizations.of(context)!.lastUpdate, value: detail.lastUpdate, divider: _divider),
              ListPair(
                title: AppLocalizations.of(context)!.otherTechnique,
                value: detail.otherTechnique,
                divider: _divider,
              ),
              ListPair(title: AppLocalizations.of(context)!.notifier, value: detail.notifier, divider: _divider),
            ],
          ),
        ),
      );
}
