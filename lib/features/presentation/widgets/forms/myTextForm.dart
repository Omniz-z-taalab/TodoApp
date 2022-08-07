import 'package:flutter/material.dart';

class MyTextForm extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? type;
  final FormFieldValidator<String>?validator;
  final GestureTapCallback?onTap;
  final double radius;
  final IconData? suffix;
  final Function()? suffixPressed;
  // final Color color;
  const MyTextForm({
    Key? key,
    // required this.color,
    required this.controller,
    this.type,
    required this.validator,
    this.onTap,
    this.radius = 0.0,
    this.suffix,
    this.suffixPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      onTap: onTap,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.red)),
        fillColor:  Theme.of(context).backgroundColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}