import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Map<dynamic, dynamic>> postData(String textField) async {
  try {
    final url = Uri.parse('http://10.0.2.2:5000/api/predict');
    Map<String, String> data = {'text': textField};
    String body = jsonEncode(data);
    // Use `data` in request body if using Node.js server as backend
    // Use `body` in request body if using FastAPI server as backend
    final response =
        await http.post(url, body: body).timeout(const Duration(seconds: 2));
    Map<dynamic, dynamic> temp = await json.decode(response.body);
    print(temp);
    return temp;
  } catch (e) {
    print("ERROR - $e");
    return {"msg": "Bad Request or Server might be down :("};
  }
}

TextField customTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.black,
      ),
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
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

const kBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      // Color(0xFF2C2B2B),
      // Color(0xFF1D1C1C),

      Color(0xFF401141),
      Color(0xFF3D113E),
      Color(0xFF381139),
      Color(0xFF2E0530),
      Color(0xFF2B112C),
      Color(0xFF261026),
      Color(0xFF200420),
      Color(0xFF1A0F1A),
      // Color(0xFF170316),
      Color(0xFF060106),
      Color(0xFF070107),

      // Color(0xFF270070),
      // Color(0xFF270183),
      // Color(0xFF270082),
      // Color(0xFF270065),
      // Color(0xFF280048),
      // Color(0xFF280047),
      // Color(0xFF280047),
      // Color(0xFF280047),
      // Color(0xFF280047),
    ],
  ),
);

const kHomepageText = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontFamily: 'OpenSans',
);
