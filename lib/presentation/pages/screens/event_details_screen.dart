import 'package:app/presentation/pages/screens/widgets/list_pair.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListView.builder(
            itemCount: _mockedContent.length,
            itemBuilder: (context, index) {
              final String name = _mockedContent.keys.elementAt(index);
              final String? value = _mockedContent[name];
              return ListPair(
                name: name,
                value: value,
              );
            }),
      ),
    );
  }
}
