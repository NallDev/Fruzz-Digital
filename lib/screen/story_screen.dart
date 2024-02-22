import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/constant.dart';

import '../widget/circle_story.dart';
import '../widget/main_story.dart';

class MyStoryScreen extends StatelessWidget {
  const MyStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: RichText(
          text: TextSpan(
            text: fruzz,
            style: myTextTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
            children: [
              TextSpan(
                text: digital,
                style: myTextTheme.titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go(loginPath);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 56.0,
                          height: 56.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40.0)),
                          ),
                          child: const Center(
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "Add Story",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CircleStory(
                        image: assetBackgroundWelcome,
                        name: index.toString(),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16.0),
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return MainStory(
                  image: assetBackgroundWelcome,
                  name: "Jamal",
                  description: "Description",
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              itemCount: 4,
            ),
            SizedBox(height: 16.0,),
          ],
        ),
      ),
    );
  }
}
