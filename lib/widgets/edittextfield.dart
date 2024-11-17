import 'package:flutter/material.dart';

class Edittextfield extends StatelessWidget {
  final InputBorder inputBorder;
  final String label;
  final TextEditingController textEditingController;
  const Edittextfield(
      {super.key,
      required this.inputBorder,
      required this.label,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextField(
        controller: TextEditingController(),
        autofocus: false,
        decoration: InputDecoration(
          border: inputBorder,
          label: Text(label),
        ),
      ),
    );
  }
}
