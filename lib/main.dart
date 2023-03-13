import 'package:flutter/material.dart';
// import 'bottomNav.dart';
import 'components/navbar2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Color(0xFF270070),
      ),
      home: BottomNav(),
    );
  }
}

