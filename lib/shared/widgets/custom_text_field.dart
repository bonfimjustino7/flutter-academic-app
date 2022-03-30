import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.maxLines,
    required this.validator,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final int? maxLines;

  final String? Function(String? text) validator;
  final void Function(String? text) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Esse campo não pode ser nulo';
        }
        return validator(text);
      },
      onSaved: onSaved,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
