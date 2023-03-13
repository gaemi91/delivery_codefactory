import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    this.errorText,
    this.hintText,
    this.obscureText = false,
    this.autoFocus = false,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      cursorColor: Color_Main,
      autofocus: autoFocus,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: errorText,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color_Text, fontSize: 14.0),
        filled: true,
        fillColor: Color_TextField_BG,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color_TextField_Border, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color_TextField_Border, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Color_Main, width: 1.0),
        ),
      ),
    );
  }
}
