import 'package:flutter/material.dart';
import 'package:my_story_app/theme/color_schemes.dart';

class MyButton extends StatelessWidget {
  final String text;
  final ButtonStyle style;
  final Function()? onPressed;

  const MyButton._({Key? key, required this.text, required this.style, this.onPressed})
      : super(key: key);

  static MyButton filled({Key? key, required String text, required Function() onPressed}) {
    return MyButton._(key: key, text: text, style: ButtonStyle.filled, onPressed: onPressed,);
  }

  static MyButton outlined({Key? key, required String text, required Function() onPressed}) {
    return MyButton._(key: key, text: text, style: ButtonStyle.outlined, onPressed: onPressed);
  }

  static MyButton disabled({Key? key, required String text}) {
    return MyButton._(text: text, style: ButtonStyle.disabled, onPressed: null);
  }

  @override
  Widget build(BuildContext context) {
    if (style == ButtonStyle.filled) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(darkColor),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(double.infinity, 64.0)),
        child: Text(text),
      );
    } else if (style == ButtonStyle.outlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(darkColor),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(darkColor), width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(double.infinity, 64.0),
        ),
        child: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(double.infinity, 64.0)),
        child: Text(text),
      );
    }
  }
}

enum ButtonStyle { filled, outlined, disabled }
