import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_dialog_box.dart';
import 'package:spott/utils/constants/app_colors.dart';

void showSpottRequestAcceptedConfirmationDialogBox(
  BuildContext context,
  String userName,
) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AppDialogBox(
        title: Text(LocaleKeys.youAreSpotted.tr()),
        image: 'assets/icons/you_spotted.svg',
        button: AppButton(
          text: LocaleKeys.ok.tr(),
          backGroundGradient: AppColors.darkPurpleGradient,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        description: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: 'The user ',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextSpan(
                text:userName,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.045)),
            TextSpan(
              text:
                  ' has confirmed your identity, he has just spotted you! You got a Spotted point!',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ], style: TextStyle(color: Colors.black)),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}
