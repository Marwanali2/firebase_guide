import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.onChanged,
    required this.onFieldSubmitted,
    required this.enabledBorderColor,
    required this.focusedBorderColor,
    required this.borderColor,
    required this.labelTextColor,
    required this.hintTextColor,
    required this.inputTextColor,
    required this.controller,
    this.keyboardType,
  });

  String? label;
  String? hintText;
  Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  Color? enabledBorderColor;
  Color? focusedBorderColor;
  Color? borderColor;
  Color? inputTextColor;
  Color? labelTextColor;
  Color? hintTextColor;
  TextInputType? keyboardType;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Color(0xff48B2E7),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return 'must not be empty';
      },
      style: TextStyle(color: inputTextColor),
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: enabledBorderColor!),
            borderRadius: BorderRadius.circular(20)),
        //
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: focusedBorderColor!),
            borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor!),
            borderRadius: BorderRadius.circular(20)),

        label: Text(
          "$label",
          style: TextStyle(
            color: labelTextColor,
          ),
        ),
        hintText: "$hintText",
        hintStyle: TextStyle(
          color: hintTextColor,
        ),
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
