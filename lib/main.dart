import 'package:flutter/material.dart';
import 'package:my_story_app/util/color_schemes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'navigation/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          routeInformationParser: routes.routeInformationParser,
          routerDelegate: routes.routerDelegate,
          routeInformationProvider: routes.routeInformationProvider,
        );
      },
    );
  }
}
