import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:my_story_app/data/model/stories/stories_response.dart';
import 'package:my_story_app/screen/camera_screen.dart';
import 'package:my_story_app/screen/detail_screen.dart';
import 'package:my_story_app/screen/login_screen.dart';
import 'package:my_story_app/screen/post_story_screen.dart';
import 'package:my_story_app/screen/register_screen.dart';
import 'package:my_story_app/screen/welcome_screen.dart';
import 'package:my_story_app/util/constant.dart';

import '../screen/story_screen.dart';

GoRouter createAppRouter(bool hasSession) {
  return GoRouter(
    initialLocation: hasSession ? storyPath : welcomePath,
    debugLogDiagnostics: true,
    
    routes: [
      GoRoute(
        path: welcomePath,
        builder: (context, state) => const MyWelcomeScreen(),
      ),
      GoRoute(
        path: loginPath,
        builder: (context, state) => const MyLoginScreen(),
      ),
      GoRoute(
        path: registerPath,
        builder: (context, state) => const MyRegisterScreen(),
      ),
      GoRoute(
        path: storyPath,
        builder: (context, state) => const MyStoryScreen(),
      ),
      GoRoute(
        path: cameraPath,
        builder: (context, state) => MyCameraScreen(),
      ),
      GoRoute(path: postStoryPath,
      builder: (context, state) => MyPostStoryScreen(imagePath: state.extra as File),),
      GoRoute(path: detailStoryPath,
      builder: (context, state) => MyDetailScreen(listStory: state.extra as ListStory),)
    ],
  );
}
