import 'package:go_router/go_router.dart';

import '../screen/login_screen.dart';
import '../screen/register_screen.dart';
import '../screen/welcome_screen.dart';

final routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyWelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const MyLoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const MyRegisterScreen(),
    ),
  ],
);
