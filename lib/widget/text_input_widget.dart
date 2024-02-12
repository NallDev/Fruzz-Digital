import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../provider/form_provider.dart';
import '../theme/color_schemes.dart';

class MyTextInput extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final Widget? suffixIcon;
  final FormProvider formProvider;
  final bool? useEmailValidator;
  final bool? useLengthValidator;
  final String field;

  const MyTextInput._({
    Key? key,
    required this.hint,
    this.obscureText = false,
    this.suffixIcon,
    required this.formProvider,
    this.useLengthValidator = false,
    this.useEmailValidator = false,
    required this.field,
  }) : super(key: key);

  static MyTextInput basic({
    Key? key,
    required String hint,
    required FormProvider formProvider,
    bool? useEmailValidator = false,
    required String field
  }) {
    return MyTextInput._(key: key, hint: hint, formProvider: formProvider, useEmailValidator: useEmailValidator, field: field,);
  }

  static MyTextInput password({
    Key? key,
    required String hint,
    bool isShowIcon = false,
    required FormProvider formProvider,
    bool? useLengthValidator = false,
    required String field,
  }) {
    Widget? icon = isShowIcon
        ? SvgPicture.asset(
      "assets/images/eye_filled.svg",
      fit: BoxFit.scaleDown,
    )
        : null;
    return MyTextInput._(
        key: key, hint: hint, obscureText: true, suffixIcon: icon, formProvider: formProvider, useLengthValidator: useLengthValidator, field: field,);
  }

  @override
  MyTextInputState createState() => MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  late bool _obscureText;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _controller = TextEditingController();

    _controller.addListener(() {
      widget.formProvider.setValue(widget.field, _controller.text);
      if (widget.useEmailValidator == true) {
        widget.formProvider.validateEmail(widget.field, _controller.text);
      } else if (widget.useLengthValidator == true) {
        widget.formProvider.validateMinEightChar(widget.field, _controller.text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: _obscureText,
      style: const TextStyle(color: Color(darkColor), fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
          onLongPressUp: () {
            _toggleVisibility();
          },
          onLongPressDown: (details) {
            _toggleVisibility();
          },
          child: widget.suffixIcon,
        )
            : null,
        filled: true,
        fillColor: const Color(backgroundColor),
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Color(grayColor), fontWeight: FontWeight.w400),
        errorText: widget.formProvider.getErrorText(widget.field),
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