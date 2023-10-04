import 'package:flutter/material.dart';

class ReUseTextFiledForm extends StatelessWidget {
  final String label;
  //final String decoration;

  final  Icon icon;
  final String hint;
  final TextEditingController controller;
  ReUseTextFiledForm({  required this.label,required this.icon,
      required this.hint, required this.controller ,super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText:hint,
          label: Text(label),
        prefixIcon: icon,
        border: OutlineInputBorder()
      )

    );
  }
}
