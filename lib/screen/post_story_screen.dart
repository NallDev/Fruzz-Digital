import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/widget/button_widget.dart';
import 'package:my_story_app/widget/text_input_widget.dart';

class MyPostStoryScreen extends StatelessWidget {
  final File imagePath;

  const MyPostStoryScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
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
                          image: FileImage(imagePath), fit: BoxFit.cover)),
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
