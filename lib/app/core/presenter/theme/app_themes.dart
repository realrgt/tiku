import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme { Light, Dark }

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[200],
    cardColor: Colors.grey[200],
    accentColor: Colors.black87,
    textTheme: TextTheme(
      headline6: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodyText1: GoogleFonts.poppins(fontSize: 18.0, color: Colors.black87),
      bodyText2: GoogleFonts.poppins(fontSize: 15.0, color: Colors.black87),
    ),
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    cardColor: Colors.grey[900],
    accentColor: Colors.grey[300],
    textTheme: TextTheme(
      headline6: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: Colors.grey[300],
      ),
      bodyText1: GoogleFonts.poppins(fontSize: 18.0, color: Colors.grey[300]),
      bodyText2: GoogleFonts.poppins(fontSize: 15.0, color: Colors.grey[300]),
    ),
  ),
};
