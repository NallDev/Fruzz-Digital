import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_story_app/routing/app_route.dart';
import 'package:my_story_app/screen/login_screen.dart';
import 'package:my_story_app/screen/register_screen.dart';
import 'package:my_story_app/screen/story_screen.dart';
import 'package:my_story_app/screen/welcome_screen.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/theme/text_style.dart';
import 'package:my_story_app/util/constant.dart';

import 'data/local/preferences_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool hasSession = await _checkSession();
  runApp(MyApp(hasSession: hasSession,));
}

class MyApp extends StatelessWidget {
  final bool hasSession;
  const MyApp({Key? key, required this.hasSession}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter routes = createAppRouter(hasSession);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: myTextTheme,
      ),
      routeInformationParser: routes.routeInformationParser,
      routerDelegate: routes.routerDelegate,
      routeInformationProvider: routes.routeInformationProvider,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }
}

Future<bool> _checkSession() async {
  PreferencesHelper preferencesHelper = PreferencesHelper();
  var session = await preferencesHelper.getSession();
  return session != null;
}