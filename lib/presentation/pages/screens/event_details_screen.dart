import 'package:app/presentation/components/jay_container.dart';
import 'package:app/presentation/pages/widgets/list_pair.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, String> _mockedContent = {
    'Jednotka': 'Test',
    'Typ udalosti': 'Test technologie',
    'Udalost': 'Test udalosti',
    'Technika': 'Strikacka Mana',
    'Region': 'Stredocesky',
    'Obec': 'Sedlec',
    'Ulice': 'U ulu 1',
    'Objekt': 'Objekt 13',
    'Patro': '7. patro',
    'Vysvetleni': 'Dalsi vysvetleni',
    'Posledni aktualizace': '12.12.2021 11:44',
    'Ostatni technika': 'CAS 121212',
    'Oznamovatel': 'Todo'
  };

  EventDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JayContainer(
      child: ListView.builder(
          itemCount: _mockedContent.length,
          itemBuilder: (context, index) {
            final String name = _mockedContent.keys.elementAt(index);
            final String? value = _mockedContent[name];
            return ListPair(
              title: name,
              value: value,
            );
          }),
    );
  }
}
