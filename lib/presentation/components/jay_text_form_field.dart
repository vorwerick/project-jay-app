import 'package:flutter/material.dart';

class JayTextFormField extends StatelessWidget {
  final String? labelText;

  final TextEditingController? controller;

  const JayTextFormField({super.key, this.labelText, this.controller});

  @override
  Widget build(final BuildContext context) => TextFormField(
        controller: controller,
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
