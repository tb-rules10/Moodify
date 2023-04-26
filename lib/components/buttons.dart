import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GoBackButton extends StatelessWidget {
  const GoBackButton({
    super.key,
    this.padding = const EdgeInsets.only(left: 25, top: 25),
    this.iconSize,
  });

  final EdgeInsets padding;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: padding,
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: iconSize ?? 42,
            ),
          ),
        ),
      ],
    );
  }
}


class OnboardButton extends StatelessWidget {
  const OnboardButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.textStyle,
    required this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    required this.onPressed,
    this.padding
  });

  final double width;
  final double height;
  final String title;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed:  onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            ),
            backgroundColor: backgroundColor,
            side: BorderSide(
              width: 1.0,
              color: borderColor ?? Colors.transparent,
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.outfit(
              textStyle: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.textStyle,
    required this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    required this.onPressed,
    this.padding,
    required this.prefix,
  });

  final double width;
  final double height;
  final String title;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final VoidCallback onPressed;
  final Widget prefix;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: SizedBox(
        width: width,
        height: height,
        child: TextButton(
          onPressed:  onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            ),
            backgroundColor: backgroundColor,
            side: BorderSide(
              width: 1.0,
              color: borderColor ?? Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: prefix,
              ),
              Text(
                title,
                style: GoogleFonts.outfit(
                  textStyle: textStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: false,
                  child: prefix,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
