import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayProgressIndicator extends StatelessWidget {
  const JayProgressIndicator({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(strokeWidth: 3),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(AppLocalizations.of(context)!.loading),
            ),
          ],
        ),
      );
}
