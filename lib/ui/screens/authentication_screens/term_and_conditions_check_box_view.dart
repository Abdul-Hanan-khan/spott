import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_check_box.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TermAndConditionsCheckBoxView extends StatefulWidget {
  final Function(bool _isAgreedWithTerms, bool _isNotUnderAge) onChange;
  const TermAndConditionsCheckBoxView({Key? key, required this.onChange})
      : super(key: key);

  @override
  _TermAndConditionsCheckBoxViewState createState() =>
      _TermAndConditionsCheckBoxViewState();
}

class _TermAndConditionsCheckBoxViewState
    extends State<TermAndConditionsCheckBoxView> {
  bool _isAgreed = false;
  bool _isNotUnderAge = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppCheckBox(
              onValueChanged: _onTermAndConditionsAgreed,
            ),
            const SizedBox(
              width: 15,
            ),
            Row(
              children: [
                Text(
                  LocaleKeys.iAgreeToThe.tr(),
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                InkWell(
                  onTap: _launchURL,
                  child: Text(
                    LocaleKeys.termsAndConditions.tr(),
                    style: const TextStyle(color: AppColors.green, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppCheckBox(
              onValueChanged: _onAgeConfirmation,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              LocaleKeys.confirmYouAreAbove16YearsOld.tr(),
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  void _onAgeConfirmation(bool selectedValue) {
    setState(() {
      _isNotUnderAge = selectedValue;
    });
    widget.onChange.call(_isAgreed, _isNotUnderAge);
  }

  void _onTermAndConditionsAgreed(bool selectedValue) {
    setState(() {
      _isAgreed = selectedValue;
    });
    widget.onChange.call(_isAgreed, _isNotUnderAge);
  }

  void _launchURL() async {
    if (!await launch('https://helpdesk.spottat.com/')) throw 'Could not launch https://helpdesk.spottat.com/';
  }

}
