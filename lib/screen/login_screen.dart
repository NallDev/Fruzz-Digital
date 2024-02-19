import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/model/login/login_response.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/provider/form_provider.dart';
import 'package:my_story_app/provider/login_provider.dart';
import 'package:my_story_app/util/ui_state.dart';
import 'package:provider/provider.dart';

import '../theme/color_schemes.dart';
import '../theme/text_style.dart';
import '../util/constant.dart';
import '../widget/button_widget.dart';
import '../widget/text_input_widget.dart';

class MyLoginScreen extends StatelessWidget {
  const MyLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FormProvider(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Consumer<LoginProvider>(
            builder: (context, loginProvider, child) {
              final loginState = loginProvider.loginState;
              if (loginState is Success) {
                final data = loginState.data as LoginResult;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login Success')),
                  );
                  context.go('/');
                });
              } else if (loginState is Error) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(loginState.message)),
                  );
                });
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Consumer<FormProvider>(
                          builder: (context, formProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8.0,
                                ),
                                if (GoRouter.of(context).canPop()) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(borderColor),
                                            width: 1),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_back_ios_new),
                                      onPressed: () {
                                        context.pop();
                                      },
                                    ),
                                  ),
                                ],
                                SizedBox(
                                  height: 24.0,
                                ),
                                Text(
                                  'Welcome back! Glad to see you, Again!',
                                  style: myTextTheme.headlineLarge?.copyWith(
                                      color: Color(darkColor),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                MyTextInput.basic(
                                  field: email,
                                  hint: email,
                                  formProvider: formProvider,
                                  useTextEmptyValidator: true
                                ),
                                SizedBox(height: 8.0),
                                MyTextInput.password(
                                  field: password,
                                  hint: password,
                                  formProvider: formProvider,
                                  useTextEmptyValidator: true,
                                ),
                                SizedBox(height: 24.0),
                                if (formProvider.isValid(email) == true &&
                                    formProvider.isValid(password) == true) ...[
                                  MyButton.filled(
                                    text: login,
                                    onPressed: () {
                                      context.read<LoginProvider>().doLogin(
                                            formProvider.getValue(email),
                                            formProvider.getValue(password),
                                          );
                                    },
                                  ),
                                ] else ...[
                                  MyButton.disabled(
                                    text: login,
                                  ),
                                ]
                              ],
                            );
                          },
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
                          SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (GoRouter.of(context).canPop()) {
                                context.pop();
                              } else {
                                context.push('/register');
                              }
                            },
                            child: Text(
                              'Register Now',
                              style: TextStyle(color: Color(0xFF35C2C1)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
