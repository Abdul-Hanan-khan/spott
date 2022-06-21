import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/ui/ui_components/badge_count_view.dart';
import 'package:spott/utils/constants/app_colors.dart';

class AppTabBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController _tabController;
  final List<String>? labels;
  final List<String>? icons;
  final Map<String, int>?
      badges; //! send badge counts in map against label (as a a key)
  final double indicatorHeight;
  const AppTabBar(this._tabController,
      {Key? key,
      this.labels,
      this.icons,
      this.indicatorHeight = 3,
      this.badges})
      : assert(labels != null || icons != null,
            "Both labels and icons can't be null, give labels or icons"),
        super(key: key);

  @override
  _AppTabBarState createState() => _AppTabBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + indicatorHeight);
}

class _AppTabBarState extends State<AppTabBar> {
  @override
  void initState() {
    widget._tabController.addListener(() {
      if (widget.icons != null) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: widget._tabController,
        indicatorWeight: widget.indicatorHeight,
        labelPadding: EdgeInsets.zero,
        unselectedLabelColor: Colors.grey,
        indicator: ShapeDecoration(
          shape: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: widget.indicatorHeight,
            ),
          ),
          gradient: AppColors.greenGradient,
        ),
        tabs: widget.labels != null
            ? (widget.labels!
                .map<Widget>(
                  (item) => Container(
                    height: kToolbarHeight,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: BadgeCountView(
                      count:
                          widget.badges != null ? widget.badges![item] : null,
                      badgePosition: BadgePosition.topEnd(top: 5, end: -30),
                      child: Tab(text: item),
                    ),
                  ),
                )
                .toList())
            : widget.icons != null
                ? (widget.icons!
                    .map<Widget>(
                      (item) => Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Tab(
                          child: SvgPicture.asset(
                            item,
                            color: widget._tabController.index ==
                                    widget.icons!.indexOf(item)
                                ? null
                                : Colors.grey,
                            height: 24,
                          ),
                        ),
                      ),
                    )
                    .toList())
                : []);
  }
}
