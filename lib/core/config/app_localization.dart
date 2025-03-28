import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class AppLocalization {
  static const Locale locale = Locale('fa');
  static const List<Locale> supportedLocales = [Locale('fa', '')];
  static const List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static MaterialApp configureLocalization({required Widget child}) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      home: child,
    );
  }

  static MaterialApp configureLocalizationWithRouter({
    required GoRouter routerConfig,
  }) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: localizationsDelegates,
      routerConfig: routerConfig,
    );
  }
}
