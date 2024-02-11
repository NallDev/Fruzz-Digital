import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            "assets/images/background_welcome.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 12.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/branding.png",
                  height: Adaptive.w(25),
                  width: Adaptive.w(35),
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 24.0,),
                ElevatedButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Adaptive.w(90), 48.0),
                    backgroundColor: const Color(0xFF1E232C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    login,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8.0,),
                ElevatedButton(
                  onPressed: () {
                    context.go('/register');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Adaptive.w(90), 48.0),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2.0,
                        color: Color(0xFF1E232C),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    register,
                    style: TextStyle(
                      color: Color(0xFF1E232C),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
