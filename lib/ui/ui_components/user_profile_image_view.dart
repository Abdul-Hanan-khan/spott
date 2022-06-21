import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/data_models/user.dart';

class UserProfileImageView extends StatelessWidget {
  final User? _user;
  final double radius;
  final Color? backgroundColor;
  const UserProfileImageView(
    this._user, {
    Key? key,
    this.radius = 20.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: _user?.profilePicture != null
          ? CachedNetworkImageProvider(_user!.profilePicture!)
          : null,
      foregroundColor: Theme.of(context).primaryColor,
      child: (_user?.profilePicture == null &&
              _user?.username != null &&
              _user!.username!.isNotEmpty)
          ? Text(
              _user!.username![0].toUpperCase(),
              style: TextStyle(fontSize: radius + 5, color: Colors.white),
            )
          : const SizedBox(),
    );
  }
}
