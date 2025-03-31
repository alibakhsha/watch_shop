// route.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

import '../enums/product_source.dart';
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
        GoRoute(
          path: '/products/:source/:id',
          builder: (context, state) {
            final source = state.pathParameters['source'] ?? '';
            final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
            final extra = state.extra as Map<String, dynamic>? ?? {};
            final products = extra['products'] as List<ProductModel>? ?? [];
            final title = extra['title'] as String? ?? "محصولات";

            ProductSource productSource;
            switch (source) {
              case 'category':
                productSource = ProductSource.category;
                break;
              case 'brand':
                productSource = ProductSource.brand;
                break;
              case 'amazing':
                productSource = ProductSource.amazing;
                break;
              case 'newest':
                productSource = ProductSource.newest;
                break;
              case 'cheapest':
                productSource = ProductSource.cheapest;
                break;
              case 'mostExpensive':
                productSource = ProductSource.mostExpensive;
                break;
              case 'mostViewed':
                productSource = ProductSource.mostViewed;
                break;
              default:
                productSource = ProductSource.category;
            }

            return ProductsScreen(
              productSource: productSource,
              sourceId: id,
              products: products.isNotEmpty ? products : null,
              title: title,
            );
          },
        ),
      ],
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
