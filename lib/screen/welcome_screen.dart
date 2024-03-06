import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/widget/button_widget.dart';

import '../util/common.dart';

class MyWelcomeScreen extends StatelessWidget {
  const MyWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            assetBackgroundWelcome,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 80.0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Image.asset(
                    assetBranding,
                    height: 99.0,
                    width: 141.0,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  MyButton.filled(
                    text: AppLocalizations.of(context)!.login,
                    onPressed: () => context.go(loginPath),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  MyButton.outlined(
                    text: AppLocalizations.of(context)!.register,
                    onPressed: () => context.go(registerPath),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
