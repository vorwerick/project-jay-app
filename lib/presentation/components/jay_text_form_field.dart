import 'package:app/presentation/utils/dimensions.dart';
import 'package:flutter/material.dart';

class JayTextFormField extends StatelessWidget {
  final String? labelText;

  final TextEditingController? controller;

  const JayTextFormField({super.key, this.labelText, this.controller});

  @override
  Widget build(final BuildContext context) => SizedBox(
    width: Dimensions.getDeviceType() == DeviceType.Tablet ? 300: double.infinity,
    child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
           border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: labelText,
          ),
        ),
  );
}
