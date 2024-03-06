import 'package:flutter/material.dart';
import 'package:my_story_app/data/model/stories/stories_response.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/theme/text_style.dart';

class MyDetailScreen extends StatelessWidget {
  final ListStory listStory;

  const MyDetailScreen({super.key, required this.listStory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  listStory.photoUrl,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: 300.0,
                ),
                const SafeArea(
                  child: BackButton(color: Color(primaryColor)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                listStory.name,
                style: myTextTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                listStory.description,
                style: myTextTheme.labelSmall?.copyWith(color: Colors.black45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
