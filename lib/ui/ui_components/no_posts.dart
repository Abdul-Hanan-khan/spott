import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'app_button.dart';
import 'package:easy_localization/easy_localization.dart';
class NoPostView extends StatelessWidget {
  const NoPostView({this.onGpsLocationButton, Key? key}) : super(key: key);
  final VoidCallback? onGpsLocationButton;


  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/NoPost.svg'),
          const SizedBox(
            height: 30,
          ),
          //TODO: localization
          Text(
            LocaleKeys.noPostsAvailable.tr(),
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 5),
            child: Text(
              LocaleKeys.leaveALivePostOrFollowSomeone.tr(),
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
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
