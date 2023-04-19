import 'package:flutter/material.dart';
import 'package:moodify/constants/boxStyles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/buttons.dart';
import '../constants/textStyles.dart';


class RegisterScreen extends StatefulWidget {
  static String id = "RegisterScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        width: width,
        decoration: kBoxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: height*0.35,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45.0),
                    bottomRight: Radius.circular(45.0),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: width,
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/appicon.png",
                    ),
                    height: height * 0.12,
                  ),
                  Text(
                    "Let's Get Started!",
                    style: GoogleFonts.outfit(
                      textStyle: TextStyle(
                        fontSize: 35.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextInputField(
                    emailController: emailController,
                    hintText: "Enter your email",
                    labelText: "Email",
                ),
                TextInputField(
                    emailController: passwordController,
                    hintText: "Enter your password",
                    labelText: "Password",
                ),

              ],
            ),
            Column(
              children: <Widget>[
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
                      onPressed: (){},
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
                OnboardButton(
                    width: width,
                    height: height*0.08,
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 5),
                    title: "Register",
                    textStyle: kRegisterButtonTextStyle,
                    backgroundColor: Colors.white,
                    borderRadius: 16.0,
                    onPressed: (){},
                ),

                // OnboardButton(
                //     width: width,
                //     height: height*0.08,
                //     padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 5),
                //     title: "Sign In with Google",
                //     textStyle:kGoogleButtonTextStyle,
                //     backgroundColor: Colors.transparent,
                //     borderColor: Colors.white,
                //     borderRadius: 16.0,
                //     onPressed: (){},
                // ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.emailController,
    required this.labelText,
    required this.hintText,
  });

  final TextEditingController emailController;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: TextField(
        controller: emailController,
        style:  GoogleFonts.outfit(
          textStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey),
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.black,
            filled: true,
            contentPadding: const EdgeInsets.all(25.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3,
                  color: Colors.black
              ),
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
        ),
      ),
    );
  }
}
