import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moodify/pages/BottomNavbar.dart';
import 'package:moodify/pages/OnboardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/buttons.dart';
import '../../constants/textStyles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../../components/inputFields.dart';


class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({
    super.key,
    this.isNewUser = false,
  });
  static String id = "AuthenticationScreen";
  final bool isNewUser;
  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool loader = false;
  bool isError = false;
  String errorMessage = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

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
                      Visibility(
                        visible: widget.isNewUser,
                        child: TextInputField(
                          emailController: usernameController,
                          hintText: "Enter your name",
                          labelText: "Username",
                          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                          borderRadius: 8,
                          fillColor: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      TextInputField(
                        emailController: emailController,
                        hintText: "Enter your email",
                        labelText: "Email",
                        padding: (widget.isNewUser)
                            ? EdgeInsets.only(left: 25, right: 25) : null,
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
                    title: (widget.isNewUser) ? "Register" : "Log In",
                    textStyle: kOnboardingButtonTextStyle,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    borderRadius: 50.0,
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      print(prefs.getString("currentUser"));
                      if(emailController.text.trimLeft() != ""
                          && passwordController.text.trimLeft() != ""
                          && (widget.isNewUser) ? usernameController.text.trimLeft() != "" : true
                      ){
                        preAuth();
                        try{
                          UserCredential  newUser = (widget.isNewUser) ?
                          await _auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          ).timeout(const Duration(seconds: 2)) :
                          await _auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          ).timeout(const Duration(seconds: 2));
                          User? user = newUser.user;
                          if(user != null){
                            (widget.isNewUser)
                                ? await user.updateDisplayName(usernameController.text)
                                :null ;
                            var name = user.displayName;
                            int? index = name?.indexOf(" ");
                            if(index!=-1) name =  name?.substring(0, name.indexOf(" "));
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setBool("loggedIn", true);
                            setState(() {
                              loader = false;
                            });
                            Navigator.pushNamedAndRemoveUntil(context, BottomNavbar.id, ModalRoute.withName(OnboardingScreen.id));
                          }
                        }
                        on FirebaseAuthException catch (e){
                          setState(() {
                            loader = false;
                            errorMessage = e.message.toString();
                            isError = true;
                          });
                        }
                        catch(e){
                          setState(() {
                            loader = false;
                            print(e);
                            errorMessage = "An error occured. Try Again Later";
                            isError = true;
                          });
                        }
                      }
                    }
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
