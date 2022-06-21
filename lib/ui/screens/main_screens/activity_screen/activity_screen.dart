import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/activity_screen_cubit/activity_screen_cubit.dart';
import 'package:spott/models/api_responses/get_app_notifications_model.dart'
    as notifcation;
import 'package:spott/models/data_models/app_notification.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/activity_screen/show_follow_request_dialog_box.dart';
import 'package:spott/ui/screens/main_screens/activity_screen/show_spot_request_dialog_box.dart';
import 'package:spott/ui/screens/main_screens/activity_screen/spott_request_accepted_confirmation_dialog_box.dart';
import 'package:spott/ui/screens/main_screens/other_screens/post_view_screen/post_view_screen.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/app_tab_bar.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/show_snack_bar.dart';

class ActivityScreen extends StatefulWidget {

   ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late ActivityScreenCubit _activityCubit;
  Completer<void>? _refreshCompleter;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ActivityScreenCubit, ActivityScreenState>(
      listener: (context, state) {
        if (state is NotificationsErrorState) {
          _stopPullToRefreshLoader();
          // showSnackBar(context: context, message: state.message);
        } else if (state is NotificationsFetchedSuccessFully) {
          _stopPullToRefreshLoader();
        }
      },
      builder: (context, state) {
        return LoadingScreenView(
          isLoading: state is FetchingNotifications,
          child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              appBar: AppBar(
                elevation: 4,
                title: Text(
                  LocaleKeys.activity.tr(),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
                bottom: AppTabBar(
                  _tabController,
                  labels: [LocaleKeys.nearby.tr(), LocaleKeys.you.tr()],
                  badges: {
                    LocaleKeys.nearby.tr(): _activityCubit.nearbyNotifications
                        .where(
                          (element) =>
                              element.status == AppNotificationStatus.unread,
                        )
                        .length,
                    LocaleKeys.you.tr(): _activityCubit.youNotifications
                        .where(
                          (element) =>
                              element.status == AppNotificationStatus.unread,
                        )
                        .length,
                  },
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  _buildNearByNotificationView(context),
                  _buildYouNotificationView(context),
                ],
              )),
        );
      },
    );
  }

  @override
  void initState() {
    _activityCubit = BlocProvider.of<ActivityScreenCubit>(context);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _markRegularNotificationsRead();
    });
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  Widget _buildNearByNotificationView(
    BuildContext context,
  ) {
    print(
        "near by notifications => ${_activityCubit.nearbyNotifications.length}");
    _markRegularNotificationsRead();
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: (_activityCubit.nearbyNotifications.isEmpty)
          ? _buildNotificationErrorView(
              context: context,
              title: LocaleKeys.nearbyNotifications.tr(),
              message: LocaleKeys
                  .allNearbyNotificationsRequestsWillBeListedInThisPanel
                  .tr(),
            )
          : ListView.builder(
              itemCount: _activityCubit.nearbyNotifications.length,
              itemBuilder: (context, index) =>
                  _NotificationTile(_activityCubit.nearbyNotifications[index]),
            ),
    );
  }

  Widget _buildNotificationErrorView({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragDown: (value) {
        _activityCubit.getInitialNotifications();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/no_notifications.svg'),
            SizedBox(
              height: _screenHeight * 0.038,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _screenWidth / 10),
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).hintColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: _screenHeight * 0.034,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYouNotificationView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onRefresh(context),
      child: (_activityCubit.youNotifications.isEmpty)
          ? _buildNotificationErrorView(
              context: context,
              title: LocaleKeys.personalNotifications.tr(),
              message: LocaleKeys
                  .yourPersonalNotificationsRequestsWillBeListedInThisPanel
                  .tr(),
            )
          : ListView.builder(
              itemCount: _activityCubit.youNotifications.length,
              itemBuilder: (context, index) =>
                  _NotificationTile(_activityCubit.youNotifications[index]),
            ),
    );
  }

  void _markRegularNotificationsRead() {
    final List<notifcation.Notifications> _notifications =
        _tabController.index == 0
            ? _activityCubit.nearbyNotifications
            : _activityCubit.youNotifications;

    final List<notifcation.Notifications> _regularNotifications = _notifications
        .where(
          (notification) =>
              notification.status == AppNotificationStatus.unread &&
              !((notification.model == 'spot') ||
                  (notification.model == 'follow' &&
                      notification.modelData?.status == 'pending')),
        )
        .toList();

    context.read<ActivityScreenCubit>().markNotificationsRead(
        _regularNotifications.map((e) => e.id).cast<int>().toList());
  }

  Future<void> _onRefresh(BuildContext context) async {
    _activityCubit.refreshNotifications();
    return _refreshCompleter?.future;
  }

  void _stopPullToRefreshLoader() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }
}

class _NotificationTile extends StatelessWidget {
  final notifcation.Notifications _notification;

  const _NotificationTile(this._notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeStamp= getStringFromTime(DateTime.parse(_notification.createdAt));
    print(timeStamp);
    return ListTile(
      onTap: () {
        print(_notification.model);
        // print(_notification.modelData!.refId);
        _onNotificationTap(context);
      },
      tileColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        '${_notification.refUser!.username ?? ''}',
      ),
      subtitle: Text('${_notification.content ?? ''}'),
      leading: getProfile(_notification.refUser, context),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _notification.status == 'unread'
              ? const CircleAvatar(
            backgroundColor: CupertinoColors.activeOrange,
            radius: 5,
          )
              : const SizedBox(),
          const SizedBox(height: 10,),
          // Text(getStringFromTime(_notification.createdAt).toString()),
          Text(timeStamp,
            style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
          )
        ],
      )
    );
  }

  String getStringFromTime(DateTime time) {
    if (time != null) {
      return timeago.format(time, locale: 'en_short').toString();
    } else {
      return '';
    }
  }

  Widget getProfile(notifcation.Ref_user? refUser, BuildContext context) {
    return CircleAvatar(
      radius: 20.0,
      backgroundImage: refUser!.profilePicture.toString() != null
          ? CachedNetworkImageProvider(refUser.profilePicture.toString())
          : null,
      foregroundColor: Theme.of(context).primaryColor,
      child: (refUser.profilePicture == null &&
              refUser.username != null &&
              refUser.username.toString().isNotEmpty)
          ? Text(
              refUser.username.toString()[0].toUpperCase(),
              style: const TextStyle(fontSize: 20.0 + 5, color: Colors.white),
            )
          : const SizedBox(),
    );
  }

  bool _isNotificationClickAble() {
    return _notification.model != null;
  }

  void _markNotificationRead(BuildContext context) {
    // print(
    //     'unread i think => ${_notification.id} => Status => ${_notification.status}');

    if (_notification.id != null && _notification.status == 'unread') {
      // print('unread i think 1');
      context
          .read<ActivityScreenCubit>()
          .markNotificationsRead([_notification.id!]);
    }
  }

  void _onNotificationTap(BuildContext context) {
    switch (_notification.model) {
      case 'comment':
        {
          _markNotificationRead(context);
          if (_notification.modelData?.id != null) {
            // print(_notification.modelData!.id.toString());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostViewScreen(
                  0,
                  post: Post(
                    id: _notification.modelData!.id,
                  ),
                ),
              ),
            );
          } else {
            showSnackBar(context: context, message: 'Post has been deleted');
          }
          break;
        }
      case 'post':
        {
          _markNotificationRead(context);
          if (_notification.modelData?.id != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostViewScreen(
                  0,
                  post: Post(
                    id: _notification.modelData!.id,
                  ),
                ),
              ),
            );
          } else {
            showSnackBar(context: context, message: 'Post has been deleted');
          }
          break;
        }
      case 'spot':
        {
          print('notification => ${_notification.modelData?.status}');
          _markNotificationRead(context);
          if (_notification.modelData?.status == 'pending') {
            showSpotRequestDialogBox(context, _notification);
          } else if (_notification.status == 'unread' &&
              _notification.modelData?.status == 'accept') {
            _markNotificationRead(context);
            showSpottRequestAcceptedConfirmationDialogBox(
                context, _notification.modelData!.user!.username.toString());
          } else if (_notification.status == 'read') {
            print("spot post id => ${_notification.modelData?.id}");
            if (_notification.modelData?.ref?.id != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostViewScreen(
                    0,
                    post: Post(
                      id: _notification.modelData!.ref!.id,
                    ),
                  ),
                ),
              );
            } else {
              showSnackBar(context: context, message: 'Post has been deleted');
            }
          }
        }
        break;
      case 'follow':
        {
          _markNotificationRead(context);
          if (_notification.modelData?.status != 'accept') {
            showFollowRequestDialogBox(context, _notification);
          } else if (_notification.refUser != null) {
            _markNotificationRead(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ViewProfileScreen(
                  User(
                    id: _notification.refUser!.id,
                  ),
                ),
              ),
            );
          }
          break;
        }
      default:
    }
  }
}
