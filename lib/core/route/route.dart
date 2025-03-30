// route.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // برای CustomTransitionPage
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/core/route/route_name.dart';
import 'package:watch_shop/presentation/screen/cart_screen.dart';
import 'package:watch_shop/presentation/screen/home_screen.dart';
import 'package:watch_shop/presentation/screen/products_screen.dart';
import 'package:watch_shop/presentation/screen/profile_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_intro_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_sign_up_screen.dart';
import 'package:watch_shop/presentation/screen/register/register_verify_screen.dart';
import 'package:watch_shop/presentation/widgets/custom_shell_screen.dart';

import '../../logic/bloc/product_bloc.dart';
import '../../logic/event/product_event.dart';
import '../../services/api_sevice.dart';
import '../model/product_model.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

Future<String> _checkInitialRoute() async {
  final secureStorage = FlutterSecureStorage();
  final token = await secureStorage.read(key: 'token');
  debugPrint('Token on startup: $token');
  return token != null ? RouteName.home : RouteName.registerIntro;
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  redirect: (context, state) async {
    final currentPath = state.uri.toString();
    debugPrint('Current Path: $currentPath');
    if (currentPath == '/' || currentPath.isEmpty) {
      final initialRoute = await _checkInitialRoute();
      debugPrint('Redirecting to: $initialRoute');
      return initialRoute;
    }
    return null;
  },
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return CustomShellScreen(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          name: RouteName.home,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const HomeScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        child, // بدون انیمیشن
                transitionDuration: Duration.zero, // مدت زمان صفر
              ),
        ),
        GoRoute(
          path: '/cart',
          name: RouteName.cart,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: CartScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          path: '/profile',
          name: RouteName.profile,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: ProfileScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
      ],
    ),
    GoRoute(
      path: '/registerIntro',
      name: RouteName.registerIntro,
      builder: (context, state) => RegisterIntroScreen(),
    ),
    GoRoute(
      path: '/products/:categoryId',
      builder: (context, state) {
        final categoryId = int.tryParse(
          state.pathParameters['categoryId'] ?? '',
        );
        final extra = state.extra as Map<String, dynamic>? ?? {};
        final products = extra['products'] as List<ProductModel>? ?? [];
        final title = extra['title'] as String? ?? "محصولات";

        return ProductsScreen(
          categoryId: categoryId,
          products: products.isNotEmpty ? products : null,
          title: title,
        );
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
      builder: (context, state) => const RegisterSignUpScreen(),
    ),
  ],
);
