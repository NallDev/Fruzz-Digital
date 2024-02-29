import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/provider/post_story_provider.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/util/ui_state.dart';
import 'package:my_story_app/widget/button_widget.dart';
import 'package:my_story_app/widget/text_input_widget.dart';
import 'package:provider/provider.dart';

import '../util/ui_helper.dart';
import '../widget/loading_widget.dart';

class MyPostStoryScreen extends StatelessWidget {
  final File imagePath;

  const MyPostStoryScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(imagePath),
                              fit: BoxFit.cover)),
                    ),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(left: 16.0, top: 16.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(borderColor), width: 1),
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
                  ])),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: MyTextInput.basic(
                          hint: "Description", field: "description"),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: MyButton.filled(
                        text: "SEND",
                        onPressed: () {
                          context
                              .read<PostStoryProvider>()
                              .postStory(imagePath, "FIRST STORY");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
