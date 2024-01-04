import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/pages/widgets/list_event_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EventHistoryPage extends StatelessWidget {
  const EventHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.eventHistory),
        ),
        body: JayContainer(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return InkWell(
                  child: ListEventPair(
                    date: DateTime.now(),
                    name: 'Event name $index',
                  ),
                  onTap: () {
                    Fluttertoast.showToast(
                        msg: 'Event name $index', gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_SHORT);
                  });
            },
          ),
        ));
  }
}
