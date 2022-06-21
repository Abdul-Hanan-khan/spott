import 'package:flutter/material.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:spott/utils/constants/app_colors.dart';

class LoadingScreenView extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  const LoadingScreenView({Key? key, required this.child, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: AppColors.secondaryBackGroundColor,
            alignment: Alignment.center,
            child: const LoadingAnimation(),
          ),
      ],
    );
  }
}
