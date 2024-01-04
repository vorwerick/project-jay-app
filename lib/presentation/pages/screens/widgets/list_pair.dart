import 'package:app/presentation/common/jay_colors.dart';
import 'package:flutter/material.dart';

class ListPair extends StatelessWidget {
  final String name;
  final String? value;

  const ListPair({super.key, required this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(value ?? ''),
              ),
            ],
          ),
        ),
        const Divider(color: JayColors.dividerColor),
      ],
    );
  }
}
