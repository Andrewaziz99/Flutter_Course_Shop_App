import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:souqy/layout/shop_layout.dart';
import 'package:souqy/modules/login/login_screen.dart';
import 'package:souqy/modules/onboarding/onboarding_screen.dart';
import 'package:souqy/shared/bloc_observer.dart';
import 'package:souqy/shared/network/local/cache_helper.dart';
import 'package:souqy/shared/network/remote/dio_helper.dart';
import 'package:souqy/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  String token = CacheHelper.getData(key: 'token') ?? '';

  if (onBoarding) {
    if (token.isNotEmpty) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = onBoardingScreen();
  }

  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: startWidget,
    );
  }
}
