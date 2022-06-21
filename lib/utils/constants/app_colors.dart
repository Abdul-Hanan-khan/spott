import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const green = Color(0xff33CC66);
  static const lightGreen = Color(0xffD9E862);
  static const purple = Color(0xff9013FE);
  static const darkPurple = Color(0xff6950FB);
  static const secondaryBackGroundColor = Color(0xffF5F5F5);
  static const LinearGradient greenGradient = LinearGradient(colors: [
    AppColors.green,
    AppColors.lightGreen,
  ]);
  static const LinearGradient greenPurpleGradient = LinearGradient(colors: [
    AppColors.green,
    AppColors.purple,
  ]);
  static const LinearGradient darkPurpleGradient = LinearGradient(colors: [
    AppColors.darkPurple,
    AppColors.purple,
  ]);
  static const Color googleColor = Color(0xff4285F4);
  static const Color greyColor = Color(0xffC6C5C6);
}
