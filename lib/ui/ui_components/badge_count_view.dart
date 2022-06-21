import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'count_text_view.dart';

class BadgeCountView extends StatelessWidget {
  final Widget child;
  final int? count;
  final BadgePosition? badgePosition;
  const BadgeCountView(
      {Key? key, required this.child, this.count, this.badgePosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (count != null && count! > 0)
        ? Badge(
            badgeColor: CupertinoColors.activeOrange,
            position: badgePosition ??
                BadgePosition.topEnd(
                  top: -18,
                ),
            badgeContent: CountTextView(count,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Colors.white)),
            child: child)
        : child;
  }
}
