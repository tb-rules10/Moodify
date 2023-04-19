import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Image(
          image: NetworkImage(
              "https://cdn.wallpapersafari.com/42/86/xbfrMv.jpg"),
        ),
      ),
    );
  }
}
