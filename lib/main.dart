import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_shop/core/model/brand.dart';
import 'package:watch_shop/core/route/route.dart';
import 'package:watch_shop/logic/bloc/brand_bloc.dart';
import 'package:watch_shop/logic/bloc/home_bloc.dart';
import 'package:watch_shop/logic/bloc/image_picker_bloc.dart';
import 'package:watch_shop/logic/bloc/product_bloc.dart';
import 'package:watch_shop/logic/event/brand_event.dart';
import 'package:watch_shop/services/api_sevice.dart';

import 'core/config/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 858),
      builder:
          (context, child) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ImagePickerBloc()),
              BlocProvider(create: (_) => HomeBloc(ApiService())),
              BlocProvider(create: (_) => ProductBloc(ApiService())),
              BlocProvider(
                create: (_) => BrandBloc(ApiService())..add(FetchBrands()),
              ),
            ],
            child: AppLocalization.configureLocalizationWithRouter(
              routerConfig: appRouter,
            ),
          ),
    );
  }
}
