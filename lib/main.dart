import 'package:flutter/material.dart';
// import 'bottomNav.dart';
import 'components/navbar2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Color(0xFF401141),
      ),
      home: BottomNav(),
    );
  }
}

