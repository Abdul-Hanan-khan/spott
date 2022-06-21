import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'app_button.dart';
import 'package:easy_localization/easy_localization.dart';
class NoGpsErrorView extends StatelessWidget {
  const NoGpsErrorView({this.onGpsLocationButton, Key? key}) : super(key: key);
  final VoidCallback? onGpsLocationButton;

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/nogps.svg'),
          const SizedBox(
            height: 30,
          ),
          //TODO: localization
          Text(
           LocaleKeys.noGPSConnection.tr(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.045),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 5),
            child: Text(
              LocaleKeys.pleaseCheckForLocationPermission.tr(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.045),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 5),
            child: Text(
             LocaleKeys.pleaseTurnOnYourLocation.tr(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          //TODO: no gps connection

          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
