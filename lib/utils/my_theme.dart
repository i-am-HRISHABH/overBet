import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme{
  static ThemeData lightTheme(BuildContext context){
    return ThemeData(
      primarySwatch: Colors.amber,
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: GoogleFonts.latoTextTheme(),
    );
  }
  static Color darkYellow = Color(0xffFDA63E);
  static Color fadeYellow = Color(0xffF0BB53);
}