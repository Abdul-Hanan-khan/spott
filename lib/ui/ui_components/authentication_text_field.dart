import 'package:flutter/material.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'app_text_field.dart';

class AuthenticationTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? errorMessage;
  final Icon? icon;
  final bool isPassword;
  final TextInputType? keyboardType;
  const AuthenticationTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.errorMessage,
      this.icon,
      this.isPassword = false,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: UiConstants.buttonBorderRadius,
      ),
      color: AppColors.secondaryBackGroundColor,
      child: AppTextField(
        hintText: hintText,
        icon: icon,
        isPassword: isPassword,
        keyboardType: keyboardType,
        controller: controller,
        errorMessage: errorMessage,
        backGroundColor: AppColors.secondaryBackGroundColor,
        borderRadius: UiConstants.buttonBorderRadius,
      ),
    );
  }
}
