import 'package:flutter/material.dart';

class AplicationTheme {
  ThemeData applicationTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF423838),
        ),
        bodyText2: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        button: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
