import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.width = double.infinity,
    this.background = Colors.blue,
    this.isUpperCase = true,
    this.radius = 3.0,
    required this.function,
    required this.text,
  });
  final double width;
  final Color background;
  final bool isUpperCase;
  final double radius;
  final VoidCallback function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class defaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final ValueChanged<String>? onSubmit;
  final InputBorder border;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final bool isPassword;
  final FormFieldValidator<String> validate;
  final void Function(PointerDownEvent)? tapout;
  final String? label;
  final String? hint;
  final Widget? prefix;
  final IconData? suffix;
  final Function()? suffixPressed;
  final bool isClickable;
  final Color? fillcolor;
  const defaultFormField({
    super.key,
    required this.controller,
    this.tapout,
    this.fillcolor,
    required this.type,
    this.onSubmit,
    this.border = const OutlineInputBorder(),
    this.onChange,
    this.onTap,
    this.isPassword = false,
    required this.validate,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: tapout,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        fillColor: fillcolor,
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: border,
      ),
    );
  }
}

Future<bool?> toast({
  required String txt,
  color = Colors.red,
  time = 1,
}) {
  return Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      backgroundColor: color,
      textColor: Colors.green,
      fontSize: 16.0);
}

Future<dynamic> navigateto({required context, required Widget widget}) async =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

