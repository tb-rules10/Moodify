import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodify/components/buttons.dart';
import '../../components/inputFields.dart';

class RecommendationScreen extends StatefulWidget {
  static String id = "RecommendationScreen";

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, height * 0.06, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GoBackButton(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 0),
              ),
              Text(
                "How are you feeling?",
                textAlign: TextAlign.left,
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SearchInputField(
                myController: myController,
                hintText: "What do you want to listen to?",
                onSubmitted: (query){

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
