import 'package:flutter/material.dart';

import '../util/color_schemes.dart';

class MyTextInputPassword extends StatelessWidget {
  final String hint;
  final bool isShowIcon;
  const MyTextInputPassword({super.key, required this.hint, required this.isShowIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      style: const TextStyle(color: Color(darkColor), fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        suffixIcon: isShowIcon ? Icon(Icons.remove_red_eye) : null,
        filled: true,
        fillColor: const Color(backgroundColor),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(grayColor), fontWeight: FontWeight.w400),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0),),
          borderSide: BorderSide(width: 1, color: Color(primaryColor),),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(width: 1,color: Color(borderColor)),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(width: 1,)
        ),
      ),
    );
  }
}
