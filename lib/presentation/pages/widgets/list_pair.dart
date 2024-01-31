import 'package:flutter/material.dart';

class ListPair extends StatelessWidget {
  final String title;
  final String? value;

  final EdgeInsetsGeometry? padding;
  final Widget? divider;

  const ListPair({
    super.key,
    required this.title,
    this.value,
    this.divider,
    this.padding,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: padding ?? const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
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
          divider ?? const SizedBox.shrink(),
        ],
      );
}
