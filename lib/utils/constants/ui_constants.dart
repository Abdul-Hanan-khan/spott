import 'package:flutter/material.dart';

class UiConstants {
  UiConstants._();
  static const BorderRadius buttonBorderRadius =
      BorderRadius.all(Radius.circular(10));
  static const BorderRadius textFieldBorderRadius =
      BorderRadius.all(Radius.circular(30));
  static const Duration bottomNavigationBarDuration =
      Duration(milliseconds: 300);
  static EdgeInsets getFormPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20);
}
