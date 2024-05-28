import 'package:app/presentation/pages/widgets/list/list_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class JayAlarmDialog extends StatelessWidget {
  // TODO(Vojjta): Add params to onAccept callback, add init time
  final void Function()? onAccept;

  const JayAlarmDialog({super.key, this.onAccept});

  @override
  Widget build(final BuildContext context) => Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppLocalizations.of(context)!.readyToGo,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 250,
                child: Theme(
                  data: ThemeData.light(),
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    initialTimerDuration: const Duration(hours: 13, minutes: 15),
                    minuteInterval: 15,
                    // This is called when the user changes the timer's
                    // duration.
                    onTimerDurationChanged: (final Duration newDuration) {},
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    ListCheckbox(AppLocalizations.of(context)!.willArriveAtPlace),
                    ListCheckbox(AppLocalizations.of(context)!.iAmOnStandby),
                    ListCheckbox(AppLocalizations.of(context)!.changeSomeOne),
                    ListCheckbox(AppLocalizations.of(context)!.takeAed),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: context.pop, child: Text(AppLocalizations.of(context)!.back)),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.pop();
                        onAccept?.call();
                      },
                      child: Text(AppLocalizations.of(context)!.accept),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
