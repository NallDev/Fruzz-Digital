import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/provider/form_provider.dart';
import 'package:my_story_app/provider/login_provider.dart';
import 'package:my_story_app/util/common.dart';
import 'package:my_story_app/util/ui_helper.dart';
import 'package:my_story_app/util/ui_state.dart';
import 'package:my_story_app/widget/loading_widget.dart';
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
                if (GoRouter.of(context).canPop()) {
                  context.pop();
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showToast(
                      context, AppLocalizations.of(context)!.loginSuccess);
                  Future.delayed(const Duration(seconds: 2), () {
                    context.go(storyPath);
                  });
                });
              } else if (loginState is Error) {
                if (GoRouter.of(context).canPop()) {
                  context.pop();
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showToast(context, loginState.message);
                });
              } else if (loginState is Loading) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const MyLoadingWidget();
                    },
                  );
                });
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Consumer<FormProvider>(
                          builder: (context, formProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 8.0,
                                ),
                                if (GoRouter.of(context).canPop()) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(borderColor),
                                            width: 1),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: IconButton(
                                      icon:
                                          const Icon(Icons.arrow_back_ios_new),
                                      onPressed: () {
                                        context.pop();
                                      },
                                    ),
                                  ),
                                ],
                                const SizedBox(
                                  height: 24.0,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.loginGreeting,
                                  style: myTextTheme.headlineLarge?.copyWith(
                                      color: const Color(darkColor),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                MyTextInput.basic(
                                    field: emailLogin,
                                    hint: AppLocalizations.of(context)!.email,
                                    formProvider: formProvider,
                                    useTextEmptyValidator: true),
                                const SizedBox(height: 8.0),
                                MyTextInput.password(
                                  field: passwordLogin,
                                  hint: AppLocalizations.of(context)!.password,
                                  formProvider: formProvider,
                                  useTextEmptyValidator: true,
                                ),
                                const SizedBox(height: 24.0),
                                if (formProvider.isValid(emailLogin) == true &&
                                    formProvider.isValid(passwordLogin) ==
                                        true) ...[
                                  MyButton.filled(
                                    text: AppLocalizations.of(context)!.login,
                                    onPressed: () {
                                      context.read<LoginProvider>().doLogin(
                                            formProvider.getValue(emailLogin),
                                            formProvider
                                                .getValue(passwordLogin),
                                          );
                                    },
                                  ),
                                ] else ...[
                                  MyButton.disabled(
                                    text: AppLocalizations.of(context)!.login,
                                  ),
                                ]
                              ],
                            );
                          },
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
                          Text(
                            AppLocalizations.of(context)!.dontHaveAnAccount,
                            style: const TextStyle(color: Color(0xFF1E232C)),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (GoRouter.of(context).canPop()) {
                                context.pop();
                              } else {
                                context.push(registerPath);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.registerNow,
                              style: const TextStyle(color: Color(0xFF35C2C1)),
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
