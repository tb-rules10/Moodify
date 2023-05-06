import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:moodify/pages/AuthenticationScreens/AuthenticationScreen.dart';
import 'package:moodify/pages/BottomNavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: loader,
        child: SafeArea(
          child: Column(
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
                      "Connect Your Emotions",
                      style: kOnboardingTextStyle
                  ),
                  Text(
                    "With Songs That You Love",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthenticationScreen(
                              isNewUser: true,
                            ),
                          ),
                        );
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
                      setState(() {
                        loader = true;
                      });
                      _googleSignIn.signIn().then((value) async {
                        if(value == null) return;
                        final userData = await value.authentication;
                        final credential = GoogleAuthProvider.credential(
                          accessToken: userData.accessToken,
                          idToken: userData.idToken
                        );
                        var result = await _auth.signInWithCredential(credential);
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool("loggedIn", true);
                        prefs.setString(
                            'currentUser',
                             value.displayName?.substring(0, value.displayName?.indexOf(" ")) ?? "User"
                        );
                        setState(() {
                          loader = false;
                        });
                        Navigator.popAndPushNamed(context, BottomNavbar.id);
                      }).catchError((error){
                        print(error);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString()))
                        );
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a user?",
                        style:  GoogleFonts.outfit(
                          textStyle: const TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(
                              context,
                              AuthenticationScreen.id,
                          );
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
        ),
      ),
    );
  }
}
