import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  ResultsPage({super.key, required this.output});
  Map<dynamic, dynamic> output;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detected Emotion'),
      ),
      body: Center(
        child: Text(
          output["msg"] != null ? output["msg"] : output["msg"],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40.0,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
