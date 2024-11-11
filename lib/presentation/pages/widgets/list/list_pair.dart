import 'package:flutter/material.dart';

class ListPair extends StatelessWidget {
  final String title;
  final String? value;

  final EdgeInsetsGeometry? padding;
  final Widget? divider;
  final Color background;

  const ListPair({
    super.key,
    required this.title,
    this.value,
    this.divider,
    this.padding, required this.background,
  });

  @override
  Widget build(final BuildContext context) => Container(
    color: background,
    child: Column(
          children: [
            Padding(
              padding: padding ?? const EdgeInsets.all(6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 15),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(value ?? '',    style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                  ),
                ],
              ),
            ),
           Container(height: 1,color: Colors.black26,),
          ],
        ),
  );
}
