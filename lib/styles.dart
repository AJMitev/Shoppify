import 'package:flutter/material.dart';

class Styles {
  static const String FontName = 'Montserrat';
  static const double LargeTextSize = 26.0;
  static const double MediumTextSize = 20.0;
  static const double BodyTextSize = 16.0;

  static const TextStyle AppBarTextStype = TextStyle(
      fontFamily: FontName,
      fontWeight: FontWeight.w300,
      fontSize: MediumTextSize,
      color: Colors.white);

  static const TextStyle TitleTextStype = TextStyle(
      fontFamily: FontName,
      fontWeight: FontWeight.w300,
      fontSize: MediumTextSize,
      color: Colors.black);

  static const TextStyle BoughtItemTextStyle = TextStyle(
      fontFamily: FontName,
      fontWeight: FontWeight.w200,
      fontStyle: FontStyle.italic,
      fontSize: MediumTextSize,
      color: Colors.black,
      decoration: TextDecoration.lineThrough);

  static const TextStyle ItemTextStyle = TextStyle(
      fontFamily: FontName,
      fontWeight: FontWeight.w300,
      fontSize: MediumTextSize,
      color: Colors.black,
      decoration: TextDecoration.none);

  static final cancelButton =
      TextButton.styleFrom(textStyle: TextStyle(color: Colors.grey));
  static final primaryButton =
      TextButton.styleFrom(textStyle: TextStyle(color: Colors.green.shade300));
}
