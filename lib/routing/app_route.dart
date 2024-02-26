import 'package:go_router/go_router.dart';
import 'package:my_story_app/screen/login_screen.dart';
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
        builder: (context, state) => MyStoryScreen(),
      ),
    ],
  );
}
