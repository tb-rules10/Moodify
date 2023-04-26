import 'package:flutter/material.dart';
import 'package:moodify/constants/boxStyles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodify/pages/BottomNavbar.dart';
import '../../components/buttons.dart';
import '../../constants/textStyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../components/inputFields.dart';


class RegisterScreen extends StatefulWidget {
  static String id = "RegisterScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool loader = false;
  bool isError = false;
  String errorMessage = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void preAuth(){
    isError = false;
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      loader = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: loader,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GoBackButton(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextInputField(
                          emailController: emailController,
                          hintText: "Enter your email",
                          labelText: "Email",
                          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                          borderRadius: 8,
                          fillColor: Theme.of(context).colorScheme.tertiary,
                      ),
                      TextInputField(
                          emailController: passwordController,
                          hintText: "Enter your password",
                          labelText: "Password",
                          borderRadius: 8,
                          fillColor: Theme.of(context).colorScheme.tertiary,
                      ),
                      Visibility(
                        visible: isError,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Text(
                            errorMessage,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              textStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  OnboardButton(
                      width: width*0.45,
                      height: height*0.08,
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                      title: "Register",
                      textStyle: kOnboardingButtonTextStyle,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      borderRadius: 50.0,
                      onPressed: () async {
                        preAuth();
                        try{
                          final newUser = await _auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          ).timeout(const Duration(seconds: 2));
                          if(newUser != null){
                            setState(() {
                              loader = false;
                            });
                            Navigator.pushNamed(context, BottomNavbar.id);
                          }
                        }
                        on FirebaseAuthException catch (e){
                          setState(() {
                            loader = false;
                            errorMessage = e.message.toString();
                            isError = true;
                          });
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text(e.toString()))
                          // );
                        }
                        catch(e){
                          setState(() {
                            loader = false;
                            errorMessage = "An error occured. Try Again Later";
                            isError = true;
                          });
                        }
                      },
                  ),
                  SizedBox(
                    height: height*0.3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

