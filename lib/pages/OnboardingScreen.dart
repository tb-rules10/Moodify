import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moodify/pages/BottomNavbar.dart';
import 'package:moodify/pages/AppScreens/HomeScreen.dart';
import 'package:moodify/pages/AuthenticationScreens/LoginScreen.dart';
import 'package:moodify/pages/AuthenticationScreens/RegisterScreen.dart';
import '../components/buttons.dart';
import '../constants/textStyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = "OnboardingScreen";
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Image.asset(
            "assets/images/appicon.png",
            height: height * 0.13,
          ),
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
          Column(
            children: [
              OnboardButton(
                  width: width*0.85,
                  height: height*0.07,
                  title: "Register",
                  textStyle: kOnboardingButtonTextStyle,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  borderRadius: 50.0,
                  padding: EdgeInsets.all(16),
                  onPressed: (){
                    Navigator.pushNamed(context, RegisterScreen.id);
                  },
              ),
              SignInButton(
                width: width*0.85,
                height: height*0.07,
                title: "Continue with Google",
                textStyle: kOnboardingButtonTextStyle,
                prefix: Image.asset(
                  "assets/images/google-icon.png",
                  height: 30,
                  width: 30,
                ),
                backgroundColor: Colors.transparent,
                borderRadius: 50.0,
                borderColor: Colors.white,
                padding: EdgeInsets.all(16),
                onPressed: (){
                  print("clicked");
                  // _googleSignIn.signOut();
                  _googleSignIn.signIn().then((value) async {
                    print(value);
                    if(value == null) return;
                    final userData = await value.authentication;
                    final credential = GoogleAuthProvider.credential(
                      accessToken: userData.accessToken,
                      idToken: userData.idToken
                    );
                    var result = await _auth.signInWithCredential(credential);
                    Navigator.pushNamed(context, BottomNavbar.id);
                  }).catchError((error){
                    print(error);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString()))
                    );
                  });
                },
              ),
              // SignInButton(
              //   width: width*0.85,
              //   height: height*0.07,
              //   title: "Sign In with Phone number",
              //   textStyle: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.white,
              //   ),
              //   prefix: Icon(
              //     Icons.phone,
              //     size: 28,
              //     color: Colors.white,
              //   ),
              //   backgroundColor: Colors.transparent,
              //   borderRadius: 50.0,
              //   borderColor: Colors.white,
              //   padding: EdgeInsets.all(16),
              //   onPressed: (){},
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a user?",
                    style:  GoogleFonts.outfit(
                      textStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Log In",
                      style:  GoogleFonts.outfit(
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),


            ],
          )
        ],
      ),
    );
  }
}
