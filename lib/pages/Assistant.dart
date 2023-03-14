import 'package:flutter/material.dart';
import '../constants.dart';

class AssistantPage extends StatelessWidget {
  const AssistantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        child: Center(
          child: Text(
            "Chat GPT Assistant",
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
