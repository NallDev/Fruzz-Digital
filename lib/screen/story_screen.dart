import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/local/preferences_helper.dart';
import 'package:my_story_app/provider/stories_provider.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/constant.dart';
import 'package:my_story_app/util/ui_helper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../util/common.dart';
import '../widget/circle_story.dart';
import '../widget/main_story.dart';

class MyStoryScreen extends StatefulWidget {
  const MyStoryScreen({super.key});

  @override
  State<MyStoryScreen> createState() => _MyStoryScreenState();
}

class _MyStoryScreenState extends State<MyStoryScreen> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: true);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    try {
      await context.read<StoriesProvider>().getStories();
    } finally {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    final randomStories = context.watch<StoriesProvider>().randomStory;
    final mainStories = context.watch<StoriesProvider>().listStory;
    final needUpdate = context.watch<StoriesProvider>().needUpdate;

    if (needUpdate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshController.requestRefresh();
        context.read<StoriesProvider>().resetUpdate();
      });
    }

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
            onPressed: () async {
              try {
                await PreferencesHelper().deleteSession();
                if (!context.mounted) return;
                context.go(loginPath);
              } catch (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showToast(context,
                      AppLocalizations.of(context)!.deleteSessionErrorMsg);
                });
              }
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: const ClassicHeader(),
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
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
                          onTap: () {
                            context.push(cameraPath).then((_) {
                              _refreshController.requestRefresh();
                            });
                          },
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
                          AppLocalizations.of(context)!.addStory,
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
                        var story = randomStories[index];
                        return GestureDetector(
                          onTap: () =>
                              context.push(detailStoryPath, extra: story),
                          child: CircleStory(
                            image: story.photoUrl,
                            name: story.name,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16.0),
                      itemCount: randomStories.length,
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
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var story = mainStories[index];
                  return GestureDetector(
                    onTap: () => context.push(detailStoryPath, extra: story),
                    child: MainStory(
                      image: story.photoUrl,
                      name: story.name,
                      description: story.description,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: mainStories.length,
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
