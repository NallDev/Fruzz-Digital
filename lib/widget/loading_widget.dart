import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        content: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Lottie.asset('assets/LottieLogo1.json'),
        ),
      ),
    );
  }
}
