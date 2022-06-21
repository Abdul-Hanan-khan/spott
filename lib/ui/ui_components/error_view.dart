import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'app_button.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({this.onRetryPressed, Key? key}) : super(key: key);
  final VoidCallback? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/error_cloud.svg'),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.oops.tr(),
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 5),
            child: Text(
              LocaleKeys.somethingWentWrongPleaseTryAgain.tr(),
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          if (onRetryPressed != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _screenWidth / 8),
              child: AppButton(
                text: LocaleKeys.retry.tr(),
                onPressed: onRetryPressed,
              ),
            ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
