import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moodify/pages/HomeScreen.dart';
import 'package:moodify/pages/LoginScreen.dart';
import 'constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/RegisterScreen.dart';
import 'pages/OnboardingScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(Moodify());
}

class Moodify extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: HomeScreen.id,
      routes: {
        OnboardingScreen.id: (context) => OnboardingScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen(),



      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}