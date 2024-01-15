import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:souqy/modules/onboarding/onboarding_screen.dart';
import 'package:souqy/shared/bloc_observer.dart';
import 'package:souqy/shared/network/remote/dio_helper.dart';
import 'package:souqy/shared/styles/colors.dart';
import 'package:souqy/shared/styles/themes.dart';
import 'package:toast/toast.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  // await CacheHelper.init();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: onBoardingScreen(),
    );
  }
}
