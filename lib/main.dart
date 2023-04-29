import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moodify/pages/AppScreens/RadioScreen.dart';
import 'package:moodify/pages/AppScreens/RecommendationScreen.dart';
import 'package:moodify/pages/AppScreens/SearchScreen.dart';
import 'package:moodify/pages/AuthenticationScreens/AuthenticationScreen.dart';
import 'package:moodify/pages/BottomNavbar.dart';
import 'package:moodify/pages/AppScreens/HomeScreen.dart';
import 'constants/theme.dart';
import 'package:firebase_core/firebase_core.dart';
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
      initialRoute: OnboardingScreen.idadd,
      routes: {
        OnboardingScreen.id: (context) => OnboardingScreen(),
        AuthenticationScreen.id: (context) => AuthenticationScreen(),
        BottomNavbar.id: (context) => BottomNavbar(),
        HomeScreen.id: (context) => HomeScreen(),
        RecommendationScreen.id: (context) => RecommendationScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        RadioHS.id: (context) => RadioHS(),




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