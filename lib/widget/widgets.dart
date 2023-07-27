import 'package:flutter/material.dart';

class inputdata extends StatelessWidget {
  const inputdata({
    Key? key,
    required this.controller,
    this.label,
    this.validation,
    this.textInputAction,
    this.onEditingComplete,
    this.autofillHint,
    this.minline = 1,
  }) : super(key: key);
  final TextEditingController controller;
  final Iterable<String>? autofillHint;

  final int minline;
  final String? label;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      maxLines: minline,
      minLines: minline,
      controller: controller,
      autofillHints: autofillHint,
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
