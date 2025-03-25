import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/core/route/route.dart';
import 'package:watch_shop/presentation/screen/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: Size(428, 858),
      builder:
          (context, child) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: Locale('fa'),
            supportedLocales: const [Locale('fa', '')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routerConfig: initGoRouter(),
          ),
    ),
  );
}
