import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/provider/register_provider.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/common.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/util/ui_helper.dart';
import 'package:my_story_app/util/ui_state.dart';
import 'package:my_story_app/widget/button_widget.dart';
import 'package:my_story_app/widget/text_input_widget.dart';
import 'package:provider/provider.dart';

import '../provider/form_provider.dart';
import '../widget/loading_widget.dart';

class MyRegisterScreen extends StatelessWidget {
  const MyRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FormProvider(),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Consumer<RegisterProvider>(
            builder: (context, registerProvider, child) {
              final registerState = registerProvider.registerState;

              if (registerState is Success) {
                if (GoRouter.of(context).canPop()) {
                  context.pop();
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showToast(
                      context, AppLocalizations.of(context)!.registerSuccess);
                  context.go(loginPath);
                });
              } else if (registerState is Error) {
                if (GoRouter.of(context).canPop()) {
                  context.pop();
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showToast(context, registerState.message);
                });
              } else if (registerState is Loading) {
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
                        child: Column(
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
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new),
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
                              AppLocalizations.of(context)!.registerGreeting,
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
                                  hint: AppLocalizations.of(context)!.username,
                                  formProvider: formProvider,
                                  useTextEmptyValidator: true,
                                );
                              },
                            ),
                            const SizedBox(height: 8.0),
                            Consumer<FormProvider>(
                              builder: (context, formProvider, child) {
                                return MyTextInput.basic(
                                  field: emailRegister,
                                  hint: AppLocalizations.of(context)!.email,
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
                                    hint:
                                        AppLocalizations.of(context)!.password,
                                    isShowIcon: true,
                                    formProvider: formProvider,
                                    useLengthValidator: true);
                              },
                            ),
                            const SizedBox(height: 24.0),
                            Consumer<FormProvider>(
                              builder: (context, formProvider, child) {
                                if (formProvider.isValid(emailRegister) ==
                                        true &&
                                    formProvider.isValid(passwordRegister) ==
                                        true &&
                                    formProvider.isValid(usernameRegister) ==
                                        true) {
                                  return MyButton.filled(
                                    text:
                                        AppLocalizations.of(context)!.register,
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
                                } else {
                                  return MyButton.disabled(
                                    text:
                                        AppLocalizations.of(context)!.register,
                                  );
                                }
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
                          Text(
                            AppLocalizations.of(context)!.alreadyHaveAnAccount,
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
                                context.push(loginPath);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
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
