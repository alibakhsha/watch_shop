import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watch_shop/core/route/route.dart';
import 'package:watch_shop/presentation/screen/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 858),
      builder: (context, child) {
        return FutureBuilder<GoRouter>(
          future: initGoRouter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }

            if (snapshot.hasError) {
              return MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: Text('خطا در مقداردهی مسیرها'),
                  ),
                ),
              );
            }

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              locale: const Locale('fa'),
              supportedLocales: const [Locale('fa', '')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routerConfig: snapshot.data!,
            );
          },
        );
      },
    );
  }
}
