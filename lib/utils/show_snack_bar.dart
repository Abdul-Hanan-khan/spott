import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
