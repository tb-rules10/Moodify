import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:moodify/pages/OnboardingScreen.dart';
import 'package:moodify/pages/delete/RegisterScreen.dart';
import '../../constants/textStyles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/buttons.dart';

class OnboardingScreen2 extends StatefulWidget {
  static String id = "OnboardingScreen2";
  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Image.network(
          // "https://wallpaperaccess.com/full/5478575.jpg",
          "https://i.pinimg.com/564x/b4/98/3e/b4983ed514f1aa019b0ee2199083019a.jpg",
          // "https://i.pinimg.com/564x/bc/78/50/bc7850ad95e793a043e7382619a698f2.jpg",
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Container(
                        //   child: Image.asset(
                        //       "assets/images/appicon.png",
                        //   ),
                        //   height: height * 0.075,
                        // ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          children: [
                            Text(
                              "Moodify",
                              style: GoogleFonts.outfit(
                                textStyle: TextStyle(
                                  fontSize: 45.0,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: width,
                  height: height * 0.3,
                  decoration: BoxDecoration(
                      // color: Colors.redAccent.withOpacity(0.19),
                    color: Color(0xff1B0C09).withOpacity(0.6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                              "Enjoy Music",
                            style: kOnboardingTextStyle
                          ),
                          Text(
                              "Curated Just For You",
                            style: kOnboardingTextStyle,
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OnboardButton(
                              title: "Register",
                              backgroundColor: Colors.white.withOpacity(0),
                              width: width*0.40,
                              height: height*0.07,
                              borderColor: Colors.white,
                              textStyle: kOnboardingButtonTextStyle,
                              borderRadius: 18.0,
                              onPressed: (){
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                          ),
                          OnboardButton(
                              title: "Log In",
                              backgroundColor: Colors.white.withOpacity(0),
                              width: width*0.40,
                              height: height*0.07,
                              borderColor: Colors.white,
                              textStyle: kOnboardingButtonTextStyle,
                              borderRadius: 18.0,
                              onPressed: (){
                                Navigator.pushNamed(context, OnboardingScreen.id);
                              },
                          ),

                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}





// Padding(
//   padding: const EdgeInsets.all(15.0),
//   child: SlideAction(
//     borderRadius: 12,
//     elevation: 0,
//     innerColor: Colors.black.withOpacity(0.5),
//     outerColor: Colors.white.withOpacity(0.5),
//     sliderButtonIcon: Icon(
//       Icons.arrow_forward,
//       color: Colors.white,
//     ),
//     text: "Get Started!",
//     textStyle: kOnboardingButtonTextStyle,
//     sliderRotate: false,
//     onSubmit: (){
//       Navigator.pushNamed(context, AuthenticationScreen.id);
//     },
//   ),
// )