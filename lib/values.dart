// Colors
import 'package:flutter/material.dart';

class AppColors {
  static const white = Color(0xffffffff);
  static const primary = Color(0xffd42a47);
  static const secondary = Color(0xffe35454);
  static const black = Color(0xff121212);
  static const dark = Color(0xff454545);
  static const main = [primary, secondary];
}

class AppDimens {
  static const minPadding = 2.5;
  static const tinyPadding = 5.0;
  static const smallPadding = 10.0;
  static const screenPadding = 20.0;
  static const arcMinHeight = 85.0;
  static const arcMaxHeight = 145.0;
  static const loadSize = 12.0;
  static const spriteSize = 75.0;
}

class AppDurations {
  static const arcDuration = Duration(milliseconds: 400);
}

class AppStyles {
  static var buttonShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0));
  static var circleShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000.0));

  static const textStyle = TextStyle(fontSize: 14.0, color: AppColors.black);
  static const buttonTextStyle = TextStyle(color: AppColors.white);
  static const whiteTitleStyle = TextStyle(
      fontSize: 16.0, color: AppColors.white, fontWeight: FontWeight.bold);

  static const gradientDecor = BoxDecoration(
      gradient: LinearGradient(
          colors: AppColors.main,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter));
}