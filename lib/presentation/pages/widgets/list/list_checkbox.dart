import 'package:flutter/material.dart';

class ListCheckbox extends StatefulWidget {
  final String title;
  final bool isChecked;

  final void Function(bool)? onChanged;

  const ListCheckbox(this.title, {super.key, this.isChecked = false, this.onChanged});

  @override
  State<ListCheckbox> createState() => _ListCheckboxState();
}

class _ListCheckboxState extends State<ListCheckbox> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
                widget.onChanged?.call(value ?? false);
              },
            ),
          ),
          const SizedBox(width: 10),
          Text(widget.title),
        ],
      );
}
