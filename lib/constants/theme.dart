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

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: false).copyWith(
      scaffoldBackgroundColor: Color(0xFF07040A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
      ),
      textTheme: const TextTheme(
        // bodyMedium: TextStyle(color: Colors.white),
        // bodyLarge: TextStyle(color: Colors.white),
        // bodySmall: TextStyle(color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Color(0xFFB80454),
        secondary: Colors.white,
        tertiary: Color(0xFF232425),
      )
  );

}