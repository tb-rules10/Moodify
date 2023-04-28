import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    super.key,
    this.myController,
    required this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.borderRadius,
  });

  final TextEditingController? myController;
  final String hintText;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onChanged;
  final double? borderRadius;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
            borderSide:
            BorderSide(width: 3, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10))
        ),
      ),
      onSubmitted: onSubmitted ?? onChanged,
      onChanged: onChanged,
    );
  }
}


class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.emailController,
    required this.labelText,
    required this.hintText,
    this.padding,
    this.borderRadius,
    this.obscureText,
    required this.fillColor,
  });

  final TextEditingController emailController;
  final String hintText;
  final String labelText;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool? obscureText;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(25.0),
      child: TextField(
        controller: emailController,
        obscureText: obscureText ?? false,
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
          fillColor: fillColor,
          filled: true,
          contentPadding: const EdgeInsets.all(25.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                width: 3,
                color: Colors.black
            ),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
          ),
        ),
      ),
    );
  }
}
