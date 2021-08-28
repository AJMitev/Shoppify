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

  static const TextStyle NoItemsTitleTextStype = TextStyle(
      fontFamily: FontName,
      fontWeight: FontWeight.w300,
      fontSize: 19.0,
      fontStyle: FontStyle.normal,
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

  static final TextStyle primaryButtonTextStyle = TextStyle(
    fontFamily: FontName,
    fontWeight: FontWeight.bold,
    color: Colors.yellow.shade800,
  );

  static final TextStyle cancelButtonTextStyle = TextStyle(
    fontFamily: FontName,
    fontWeight: FontWeight.normal,
    color: Colors.grey,
  );

  static const TextStyle InputHintTextStyle = TextStyle(
      color: Colors.grey,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w100);

  static const TextStyle InputLabelTextStyle = TextStyle(
      color: Colors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300);

  static final primaryColor = Colors.yellow.shade800;

  static final cancelButton = TextButton.styleFrom(
      primary: Colors.grey, textStyle: cancelButtonTextStyle);

  static final primaryButton = TextButton.styleFrom(
      primary: primaryColor, textStyle: primaryButtonTextStyle);
}
