import 'package:flutter/material.dart';
import 'package:spott/models/data_models/user.dart';

class MessagesScreen extends StatelessWidget {
  final User _user;
  const MessagesScreen(
    this._user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(
        _user.name ?? '',
        overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
          )
      ),
    ));
  }
}
