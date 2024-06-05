import 'package:flutter/material.dart';

class JayContainer extends StatelessWidget {
  final Widget child;

  const JayContainer({super.key, required this.child});
  @override
  Widget build(final BuildContext context) => Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0),

        child: child,
      ),
    );
}
