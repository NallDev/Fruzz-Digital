import 'package:flutter/material.dart';
import 'package:my_story_app/util/color_schemes.dart';

class MyTextInput extends StatelessWidget {
  final String hint;
  const MyTextInput({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Color(darkColor), fontWeight: FontWeight.w600),
      decoration: InputDecoration(
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
