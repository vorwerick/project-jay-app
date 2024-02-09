import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/widgets/badges/badge_basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerUnitItem extends StatelessWidget {
  final String unitName;

  final String role;

  final bool hasAlert;

  const DrawerUnitItem({super.key, required this.unitName, required this.hasAlert, required this.role});

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: JayColors.lightGrey,
              child: Row(
                children: [
                  const BadgeBasic(
                    badgeColor: JayColors.blue,
                    diameter: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(unitName, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white)),
                  ),
                  const Spacer(),
                  Container(
                    color: JayColors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(role, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: hasAlert,
              child: Container(
                width: double.maxFinite,
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    AppLocalizations.of(context)!.alert,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
