import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/provider/register_provider.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/widget/button_widget.dart';
import 'package:my_story_app/widget/text_input_widget.dart';
import 'package:provider/provider.dart';

import '../provider/form_provider.dart';

class MyRegisterScreen extends StatelessWidget {
  const MyRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final message = context.watch<RegisterProvider>().message;
    final isErrorRegister = context.watch<RegisterProvider>().isErrorRegister;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }

      if (!isErrorRegister) {
        context.go('/login');
      }
    });

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
                            border:
                                Border.all(color: Color(borderColor), width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
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
                      Text(
                        'Hello! Register to get started',
                        style: myTextTheme.headlineLarge?.copyWith(
                            color: Color(darkColor),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Consumer<FormProvider>(
                        builder: (context, formProvider, child) {
                          return MyTextInput.basic(
                            field: usernameRegister,
                            hint: username,
                            formProvider: formProvider,
                          );
                        },
                      ),
                      SizedBox(height: 8.0),
                      Consumer<FormProvider>(
                        builder: (context, formProvider, child) {
                          return MyTextInput.basic(
                            field: emailRegister,
                            hint: email,
                            formProvider: formProvider,
                            useEmailValidator: true,
                          );
                        },
                      ),
                      SizedBox(height: 8.0),
                      Consumer<FormProvider>(
                        builder: (context, formProvider, child) {
                          return MyTextInput.password(
                              field: passwordRegister,
                              hint: password,
                              isShowIcon: true,
                              formProvider: formProvider,
                              useLengthValidator: true);
                        },
                      ),
                      SizedBox(height: 24.0),
                      Consumer<FormProvider>(
                        builder: (context, formProvider, child) {
                          return MyButton.filled(
                            text: 'Register',
                            onPressed: () {
                              context.read<RegisterProvider>().doRegister(
                                    formProvider.getValue(usernameRegister),
                                    formProvider.getValue(emailRegister),
                                    formProvider.getValue(passwordRegister),
                                  );
                            },
                          );
                        },
                      ),
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
                    SizedBox(
                      width: 8.0,
                    ),
                    GestureDetector(
                      onTap: () => context.push('/login'),
                      child: Text(
                        'Login Now',
                        style: TextStyle(color: Color(0xFF35C2C1)),
                      ),
                    )
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
