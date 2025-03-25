import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/presentation/screen/home_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_intro_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
// ignore: unused_element
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

initGoRouter() {
  return GoRouter(
    initialLocation: RouteName.registerIntro,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/home',
        name: RouteName.home,
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: '/registerIntro',
        name: RouteName.registerIntro,
        builder: (context, state) {
          return RegisterIntroScreen();
        },
      ),
    ],
  );
}
