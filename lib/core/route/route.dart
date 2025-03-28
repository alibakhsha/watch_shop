import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/presentation/screen/home_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_intro_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_sign_up_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_verify_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

Future<String> _checkInitialRoute() async {
  final secureStorage = FlutterSecureStorage();
  final token = await secureStorage.read(key: 'token');
  debugPrint('Token on startup: $token'); // پرینت برای دیباگ
  return token != null ? RouteName.home : RouteName.registerIntro;
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/', // ریشه، که ریدایرکت تصمیم می‌گیره
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) async {
    final currentPath = state.uri.toString();
    debugPrint('Current Path: $currentPath'); // پرینت مسیر فعلی

    // فقط وقتی اپلیکیشن تازه باز شده، مسیر رو چک کن
    if (currentPath == '/' || currentPath.isEmpty) {
      final initialRoute = await _checkInitialRoute();
      debugPrint('Redirecting to: $initialRoute');
      return initialRoute;
    }
    return null; // اگه کاربر توی یه مسیر خاصه، دستکاری نکن
  },
  routes: [
    GoRoute(
      path: '/home',
      name: RouteName.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/registerIntro',
      name: RouteName.registerIntro,
      builder: (context, state) => RegisterIntroScreen(),
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
      builder: (context, state) => const RegisterSignUpScreen(),
    ),
  ],
);