import 'package:app/presentation/pages/widgets/list_pair.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListEventPair extends StatelessWidget {
  final DateTime date;
  final String name;

  const ListEventPair({super.key, required this.date, required this.name});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: Colors.white,
            child: ListPair(
              title: DateFormat.yMd().format(date),
              value: name,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            )),
      );
}
