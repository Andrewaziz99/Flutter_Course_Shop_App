import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqy/layout/shop_layout.dart';
import 'package:souqy/modules/login/login_screen.dart';
import 'package:souqy/modules/onboarding/onboarding_screen.dart';
import 'package:souqy/shared/bloc_observer.dart';
import 'package:souqy/shared/components/constants.dart';
import 'package:souqy/shared/cubit/cubit.dart';
import 'package:souqy/shared/network/local/cache_helper.dart';
import 'package:souqy/shared/network/remote/dio_helper.dart';
import 'package:souqy/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  TOKEN = CacheHelper.getData(key: 'token') ?? '';

  if (onBoarding) {
    if (TOKEN.isNotEmpty) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = onBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget startWidget;
  final bool isDark;

  MyApp({required this.startWidget, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCatData()..getFavourites(),
      child: MaterialApp(
        theme: isDark ? darkTheme : lightTheme,
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
