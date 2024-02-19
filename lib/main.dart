import 'package:flutter/material.dart';
import 'package:my_story_app/theme/color_schemes.dart';
import 'package:my_story_app/theme/text_style.dart';

import 'routing//router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Story App',
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