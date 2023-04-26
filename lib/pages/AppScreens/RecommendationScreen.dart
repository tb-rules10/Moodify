import 'package:flutter/material.dart';

class RecommendationScreen extends StatefulWidget {
  static String id = "RecommendationScreen";

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text("I'm Vengeance"),
      ),
      body: const Center(
        child: Image(
          image: NetworkImage(
              "https://cdn.wallpapersafari.com/42/86/xbfrMv.jpg"),
        ),
      ),
    );
  }
}
