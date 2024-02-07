import 'package:app/presentation/components/jay_drawer.dart';
import 'package:app/presentation/components/jay_white_text.dart';
import 'package:app/presentation/navigation/app_routes.dart';
import 'package:app/presentation/pages/widgets/event_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class HomeInactivePage extends StatelessWidget {
  const HomeInactivePage({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(title: JayWhiteText(AppLocalizations.of(context)!.noActiveAlarms)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EventHeader(title: AppLocalizations.of(context)!.noActiveAlarmHeader),
            const SizedBox(height: 120),
            JayWhiteText(AppLocalizations.of(context)!.meantimeYouCanEvents, fontSize: 18),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.eventHistory.name);
                },
                child: Text(AppLocalizations.of(context)!.history),
              ),
            ),
          ],
        ),
        drawer: const JayDrawer(),
      );
}
