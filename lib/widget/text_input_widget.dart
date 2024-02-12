import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/color_schemes.dart';

class MyTextInput extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;

  const MyTextInput._({
    Key? key,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  static MyTextInput basic({Key? key, required String hint}) {
    return MyTextInput._(key: key, hint: hint);
  }

  static MyTextInput password(
      {Key? key, required String hint, bool isShowIcon = false}) {
    Widget? icon = isShowIcon
        ? SvgPicture.asset(
            "assets/images/eye_filled.svg",
            fit: BoxFit.scaleDown,
          )
        : null;
    return MyTextInput._(
        key: key, hint: hint, obscureText: true, suffixIcon: icon);
  }

  @override
  MyTextInputState createState() => MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      style:
          const TextStyle(color: Color(darkColor), fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTapUp: (details) {
                  _toggleVisibility();
                },
                onTapDown: (details) {
                  _toggleVisibility();
                },
                child: widget.suffixIcon,
              )
            : null,
        filled: true,
        fillColor: const Color(backgroundColor),
        hintText: widget.hint,
        hintStyle: const TextStyle(
            color: Color(grayColor), fontWeight: FontWeight.w400),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(width: 1, color: Color(primaryColor)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(width: 1, color: Color(borderColor)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(width: 1),
        ),
      ),
    );
  }
}
