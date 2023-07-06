import 'package:flutter/material.dart';

class inputdata extends StatelessWidget {
  const inputdata({
    Key? key,
    required this.controller,
    this.label,
    this.validation,
    this.minline,
  }) : super(key: key);
  final TextEditingController controller;

  final int? minline;
  final String? label;

  final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: minline,
      minLines: minline,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          borderSide: BorderSide(),
        ),
      ),
      validator: validation ??
          (value) {
            if (value!.isEmpty) {
              return 'Please enter the field';
            }
            return null;
          },
    );
  }
}
