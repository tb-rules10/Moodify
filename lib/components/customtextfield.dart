import 'package:flutter/material.dart';

TextField customTextField(String text,IconData icon,bool isPasswordType,TextEditingController controller){

  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    decoration: InputDecoration(
      prefixIcon: Icon (icon,color: Colors.black,),
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 5,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
      ),
    ),
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );

}


Container signinbuttons( BuildContext context , bool isLogin , Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.black; // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          )
      ),
      child: Text(
        isLogin ? "Log In" : "Sign Up",
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
      ),
    ),
  );
}