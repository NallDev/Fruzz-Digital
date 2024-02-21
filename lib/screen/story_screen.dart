import 'package:animated_dashed_circle/animated_dashed_circle.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/constant.dart';

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
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
              children: [
                TextSpan(
                  text: digital,
                  style: myTextTheme.titleMedium
                      ?.copyWith(color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
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
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
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
                                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              ),
                              child: Center(
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "Add Story",
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Container(
                        height: 80,
                        width: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedDashedCircle().show(
                                  image: AssetImage(assetBackgroundWelcome),
                                  autoPlay: true,
                                  contentPadding: 2,
                                  height: 54.0,
                                  borderWidth: 5,
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(width: 8.0),
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
