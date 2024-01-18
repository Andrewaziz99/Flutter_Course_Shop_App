import 'package:flutter/material.dart';

import 'package:souqy/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  colorSchemeSeed: PrimaryColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Jannah',
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: PrimaryColor,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: DefaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 20.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DefaultColor,
    shape: CircleBorder(),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  colorSchemeSeed: PrimaryColor,
  scaffoldBackgroundColor: Colors.grey[900],
  fontFamily: 'Jannah',
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.grey,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    backgroundColor: Colors.grey,
    elevation: 20.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: DefaultColor,
    shape: CircleBorder(),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);
