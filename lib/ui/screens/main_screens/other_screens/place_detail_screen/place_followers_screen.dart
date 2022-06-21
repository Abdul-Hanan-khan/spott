import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/data_models/follow.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';

class PlaceFollowersScreen extends StatelessWidget {
  final List<Follow> _followers;
  const PlaceFollowersScreen(this._followers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.follower.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: _followers.length,
        itemBuilder: (context, index) => ListTile(
          leading: UserProfileImageView(_followers[index].follower),
          title: Text(_followers[index].follower?.name ?? ''),
          subtitle: Text(_followers[index].follower?.username ?? ''),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ViewProfileScreen(_followers[index].follower)));
          },
        ),
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}
