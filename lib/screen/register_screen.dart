import 'package:flutter/material.dart';
import 'package:my_story_app/util/color_schemes.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/widget/text_input.dart';
import 'package:my_story_app/widget/text_input_password.dart';

class MyRegisterScreen extends StatelessWidget {
  const MyRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text('Hello! Register to get started'),
                      MyTextInput(hint: username),
                      SizedBox(height: 8.0),
                      MyTextInput(hint: email,),
                      SizedBox(height: 8.0),
                      MyTextInputPassword(hint: password, isShowIcon: false),
                      SizedBox(height: 8.0),
                      MyTextInputPassword(hint: confirmPassword, isShowIcon: false),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {

                        },
                        child: Text('Register'),
                      ),
                      SizedBox(height: 80),
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
                      'Already have an account?',
                      style: TextStyle(color: Color(0xFF1E232C)),
                    ),
                    SizedBox(width: 8.0,),
                    Text('Login Now', style: TextStyle(color: Color(0xFF35C2C1)),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
