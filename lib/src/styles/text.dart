import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class TextStyles {
  static TextStyle get title {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
            color: AppColors.darkblue,
            fontWeight: FontWeight.bold,
            fontSize: 40.0));
  }

  static TextStyle get subtitle {
    return TextStyle(
        color: AppColors.straw, fontWeight: FontWeight.bold, fontSize: 16.0);
  }

  static TextStyle get school {
    return GoogleFonts.oswald(
        textStyle: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 15.0));
  }

  static TextStyle get nameAndLastName {
    return TextStyle(
        color: AppColors.straw, fontSize: 17.0, fontWeight: FontWeight.bold);
  }

  static TextStyle get instagram {
    return TextStyle(
        color: Color.fromRGBO(233, 89, 80, 1.0),
        fontWeight: FontWeight.bold,
        fontSize: 15.0);
  }

  static TextStyle get facebook {
    return TextStyle(
        color: AppColors.facebook, fontWeight: FontWeight.bold, fontSize: 15.0);
  }

  static TextStyle get twitter {
    return TextStyle(
        color: Color.fromRGBO(85, 172, 238, 1.0),
        fontWeight: FontWeight.bold,
        fontSize: 15.0);
  }

  static TextStyle get email {
    return TextStyle(
        color: AppColors.straw, fontWeight: FontWeight.bold, fontSize: 15.0);
  }

  static TextStyle get deneme {
    return TextStyle(color: Colors.cyan, fontSize: 15.0);
  }

  static TextStyle get age {
    return TextStyle(
        color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16.0);
  }

  static TextStyle get target {
    return TextStyle(
        color: Colors.green[400], fontWeight: FontWeight.bold, fontSize: 15.0);
  }

  static TextStyle get profession {
    return TextStyle(
        color: AppColors.google, fontWeight: FontWeight.bold, fontSize: 17.0);
  }

  static TextStyle get navTitle {
    return GoogleFonts.poppins(
        textStyle:
            TextStyle(color: AppColors.darkblue, fontWeight: FontWeight.bold));
  }

  static TextStyle get navTitleMaterial {
    return GoogleFonts.poppins(
        textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }

  static TextStyle get body {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.lightgray, fontSize: 16.0));
  }

  static TextStyle get bodyLightBlue {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.lightblue, fontSize: 16.0));
  }

  static TextStyle get bodyRed {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.red, fontSize: 16.0));
  }

  static TextStyle get picker {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.darkgray, fontSize: 35.0));
  }

  static TextStyle get link {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.straw,
            fontSize: 16.0,
            fontWeight: FontWeight.bold));
  }

  static TextStyle get suggestion {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.lightgray, fontSize: 14.0));
  }

  static TextStyle get error {
    return GoogleFonts.roboto(
        textStyle: TextStyle(color: AppColors.red, fontSize: 12.0));
  }

  static TextStyle get buttonTextLight {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold));
  }

  static TextStyle get buttonTextDark {
    return GoogleFonts.roboto(
        textStyle: TextStyle(
            color: AppColors.darkgray,
            fontSize: 17.0,
            fontWeight: FontWeight.bold));
  }
}
