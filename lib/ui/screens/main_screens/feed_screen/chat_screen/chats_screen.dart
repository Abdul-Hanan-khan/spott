import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';

import 'messages_screen.dart';

class ChatsScreen extends StatelessWidget {
  final User? currentChatUser;

  const ChatsScreen({
    Key? key,
    this.currentChatUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(
        (_) => _checkForNavigationToMessagesScreen(context));
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.chats.tr(),
            style: const TextStyle(
              color: Colors.black,
            )),
      ),
      body: _buildNoMessagesView(context),
    );
  }

  Center _buildNoMessagesView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/no_messages.svg'),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.noMessages.tr(),
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5),
            child: Text(
              LocaleKeys.youHaveNoActiveChats.tr(),
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _checkForNavigationToMessagesScreen(BuildContext context) {
    if (currentChatUser != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MessagesScreen(currentChatUser!),
        ),
      );
    }
  }
}
