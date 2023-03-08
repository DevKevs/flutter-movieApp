import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.indigo;
  static const Color darkPrimary = Colors.green;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //primary color
    primaryColor: primary,
    //appbar theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    //primary color
    primaryColor: darkPrimary,
    //appbar theme
    appBarTheme: const AppBarTheme(
      color: darkPrimary,
      elevation: 0,
    ),
  );
}
