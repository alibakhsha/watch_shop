import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/presentation/screen/home_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_intro_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_sign_up_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_verify_screen.dart';

Future<String> getInitialRoute() async {
  final secureStorage = FlutterSecureStorage();
  final token = await secureStorage.read(key: 'token');
  return token != null ? RouteName.registerSignUp : RouteName.registerIntro;
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
// ignore: unused_element
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

Future<GoRouter> initGoRouter() async {
  final initialRoute = await getInitialRoute();
  return GoRouter(
    initialLocation: initialRoute,
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
      GoRoute(
        path: '/registerVerify',
        name: RouteName.registerVerify,
        builder: (context, state) {
          final mobile = state.extra as String;
          return RegisterVerifyScreen(mobile: mobile);
        },
      ),
      GoRoute(
        path: '/registerSignUp',
        name: RouteName.registerSignUp,
        builder: (context, state) {
          return RegisterSignUpScreen();
        },
      ),
    ],
  );
}
