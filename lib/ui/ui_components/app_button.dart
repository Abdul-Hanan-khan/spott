import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'loading_animation.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String? icon;
  final Gradient? backGroundGradient;
  final Color? backGroundColor;
  final bool isLoading;

  const AppButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.icon,
      this.backGroundColor,
      this.isLoading = false,
      this.backGroundGradient})
      : assert(backGroundColor == null || backGroundGradient == null,
            'Please give background color or backGroundGradient'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: UiConstants.buttonBorderRadius,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: backGroundColor != null
                ? null
                : (backGroundGradient ?? AppColors.greenGradient),
            borderRadius: UiConstants.buttonBorderRadius,
            color: backGroundColor),
        child: isLoading
            ? const SizedBox(
                height: 23,
                child: Center(
                  child: LoadingAnimation(),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        icon!,
                        height: 21,
                      ),
                    ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
