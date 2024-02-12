import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/color_schemes.dart';
import '../theme/text_style.dart';
import '../util/constant.dart';
import '../widget/button_widget.dart';
import '../widget/text_input_widget.dart';

class MyLoginScreen extends StatelessWidget {
  const MyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(borderColor), width: 1),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Text('Welcome back! Glad to see you, Again!', style: myTextTheme.headlineLarge?.copyWith(color: Color(darkColor), fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 16.0,
                    ),
                    MyTextInput.basic(hint: email),
                    SizedBox(height: 8.0),
                    MyTextInput.password(hint: password, isShowIcon: true),
                    SizedBox(height: 24.0),
                    MyButton.filled(text: login, onPressed: () {  }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(color: Color(0xFF1E232C)),
                  ),
                  SizedBox(width: 8.0,),
                  Text('Register Now', style: TextStyle(color: Color(0xFF35C2C1)),)
                ],
              ),
            ),
          ),
        ],
      ),),
    );
  }
}
