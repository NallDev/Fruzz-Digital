import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/network/api_service.dart';
import 'package:my_story_app/provider/post_story_provider.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/util/common.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/util/ui_state.dart';
import 'package:my_story_app/widget/button_widget.dart';
import 'package:my_story_app/widget/text_input_widget.dart';
import 'package:provider/provider.dart';

import '../provider/form_provider.dart';
import '../provider/stories_provider.dart';
import '../util/ui_helper.dart';
import '../widget/loading_widget.dart';

class MyPostStoryScreen extends StatelessWidget {
  final File imagePath;

  const MyPostStoryScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostStoryProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: Consumer<PostStoryProvider>(
        builder: (context, value, child) {
          var state = context.watch<PostStoryProvider>().postStoryState;

          if (state is Loading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const MyLoadingWidget();
                },
              );
            });
          } else if (state is Success) {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<StoriesProvider>().updateStory();
              context.go(storyPath);
            });
          } else if (state is Error) {
            if (GoRouter.of(context).canPop()) {
              context.pop();
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showToast(context, state.message);
            });
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(imagePath),
                                    fit: BoxFit.cover)),
                          ),
                          SafeArea(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 16.0, top: 16.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(borderColor),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(borderColor),
                                ),
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Consumer<FormProvider>(
                          builder: (context, formProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: MyTextInput.disable(
                                          hint: formProvider.getValue(latitude).isNotEmpty ? formProvider.getValue(latitude) : latitude,
                                          field: latitude,
                                          formProvider: formProvider,
                                          useTextEmptyValidator: true),
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: MyTextInput.disable(
                                          hint: formProvider.getValue(longitude).isNotEmpty ? formProvider.getValue(longitude) : longitude,
                                          field: longitude,
                                          formProvider: formProvider,
                                          useTextEmptyValidator: true),
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                        onPressed: () => context.push(pickLocationPath),
                                        icon: Icon(
                                          Icons.add_location,
                                          color: Colors.green.shade900,
                                        ),
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.greenAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: MyTextInput.basic(
                                        hint: AppLocalizations.of(context)!
                                            .description,
                                        field: descriptionPost,
                                        formProvider: formProvider,
                                        useTextEmptyValidator: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: formProvider.isValid(
                                                      descriptionPost) ==
                                                  true &&
                                              formProvider.isValid(latitude) ==
                                                  true &&
                                              formProvider.isValid(longitude) ==
                                                  true
                                          ? MyButton.filled(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .send,
                                              onPressed: () {
                                                context
                                                    .read<PostStoryProvider>()
                                                    .postStory(
                                                        imagePath,
                                                        formProvider.getValue(
                                                            descriptionPost));
                                              },
                                            )
                                          : MyButton.disabled(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .send,
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
