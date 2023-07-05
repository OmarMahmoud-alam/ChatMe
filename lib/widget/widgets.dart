import 'package:flutter/material.dart';

class inputdata extends StatelessWidget {
  inputdata({
    Key? key,
    required this.Controller,
    this.label,
    this.validation,
    this.maxline = 1,
    this.minline,
  }) : super(key: key);
  final TextEditingController Controller;
  final int maxline;
  final int? minline;
  String? label;

  String? Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxline,
      minLines: minline,
      controller: Controller,
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
