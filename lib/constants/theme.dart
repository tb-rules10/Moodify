import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFF997af0),
        secondary: Colors.black,
        tertiary: Color(0xFF430eff),
      )
  );

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xFF1B252E),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFF1B252E),
        secondary: Colors.white,
        tertiary: Color(0xFF430eff),
      )
  );

}