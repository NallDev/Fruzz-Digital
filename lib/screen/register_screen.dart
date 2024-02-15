import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/network/api_service.dart';
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
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(apiService: ApiService()),
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RegisterProvider>(
            builder: (context, registerProvider, child) {
              if (registerProvider.registerState == RegisterState.success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(registerProvider.message.toString())),
                  );
                  context.go('/login');
                });
              } else if (registerProvider.registerState == RegisterState.error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(registerProvider.message.toString())),
                  );
                });
              }
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(borderColor),
                                          width: 1),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_back_ios_new),
                                    onPressed: () {
                                      context.pop();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Text(
                                  'Hello! Register to get started',
                                  style: myTextTheme.headlineLarge?.copyWith(
                                      color: const Color(darkColor),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
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
                                const SizedBox(height: 8.0),
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
                                const SizedBox(height: 8.0),
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
                                const SizedBox(height: 24.0),
                                Consumer<FormProvider>(
                                  builder: (context, formProvider, child) {
                                    return MyButton.filled(
                                      text: 'Register',
                                      onPressed: () {
                                        context
                                            .read<RegisterProvider>()
                                            .doRegister(
                                              formProvider
                                                  .getValue(usernameRegister),
                                              formProvider
                                                  .getValue(emailRegister),
                                              formProvider
                                                  .getValue(passwordRegister),
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
                      SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account?',
                                style: TextStyle(color: Color(0xFF1E232C)),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              GestureDetector(
                                onTap: () => context.push('/login'),
                                child: const Text(
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
                  if (registerProvider.registerState ==
                      RegisterState.loading) ...[
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(primaryColor),
                      ),
                    ),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
