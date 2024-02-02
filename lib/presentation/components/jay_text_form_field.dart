import 'package:flutter/material.dart';

class JayTextFormField extends StatelessWidget {
  final String? labelText;

  const JayTextFormField({super.key, this.labelText});

  @override
  Widget build(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: labelText,
        ),
      );
}
