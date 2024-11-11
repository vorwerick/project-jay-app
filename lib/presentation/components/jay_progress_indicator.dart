import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JayProgressIndicator extends StatelessWidget {
  final String text;
  const JayProgressIndicator({super.key, required this.text});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(backgroundColor: JayColors.primaryLight.withOpacity(0.3),color: JayColors.primary,strokeCap: StrokeCap.round,strokeAlign: 3,strokeWidth: 3,),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(text,style: TextStyle(fontSize: 16,color: Colors.black54),textAlign: TextAlign.center,),
            ),
          ],
        ),
      );
}
