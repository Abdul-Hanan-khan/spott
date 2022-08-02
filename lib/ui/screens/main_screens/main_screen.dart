import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/activity_screen_cubit/activity_screen_cubit.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/firebase_interaction/firestore_fun.dart';
import 'package:spott/ui/screens/main_screens/activity_screen/activity_screen.dart';
import 'package:spott/ui/screens/main_screens/explore_screen/explore_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_detail_screen/place_detail_screen.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/badge_count_view.dart';
import 'package:spott/utils/constants/ui_constants.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:uni_links/uni_links.dart';
import '../../../variables.dart';
import 'create_new_post_screen/create_new_post_screen.dart';
import 'feed_screen/feed_screen.dart';

import 'package:spott/models/api_responses/get_app_notifications_model.dart'
as notifcation;

class MainScreen extends StatefulWidget {
  bool isSplash;


  MainScreen(this.isSplash);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  StreamSubscription? _sub;
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  late List<Widget> _screens;
  final List<notifcation.Notifications> _notification = [];


  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 0);
  }

  @override
  void initState() {
    getUserLatLng(context).then((value) {
      setState(() {
        position = value;
      });
    });
    isFirstTimeLoading = true;
    _screens = [
      FeedScreen(
        widget.isSplash,
        _openNewSpotScreen,
        isFirstTimeLoading: isFirstTimeLoading ?? true
      ),
      const ExploreScreen(),
      CreateNewPostScreen(_openFeedScreen),
       ActivityScreen(),
      ViewProfileScreen(AppData.currentUser),
    ];
    _handleIncomingLinks();
    _handleInitialUri();
    _fetchUserNotifications(context);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      /// set state here online
      FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 1);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 1);

        break;
      case AppLifecycleState.inactive:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 0);

        break;
      case AppLifecycleState.paused:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 0);

        break;
      case AppLifecycleState.detached:
        FireStoreDatabase().changeState(AppData.currentUser!.id.toString(), 0);
        break;
    }
  }

  var foundElements;

  @override
  Widget build(BuildContext context) {
     foundElements = _notification.where((e) => e.status == 'unread');
    return BlocConsumer<ActivityScreenCubit, ActivityScreenState>(
      listener: (context, state) {
        if (state is NotificationsErrorState) {
        } else if (state is NotificationsFetchedSuccessFully) {
          _notification.clear();
          _notification.addAll(state.youNotifications);
          for (int i = 0; i < _notification.length; i++) {
            if (AppData.accessToken != null &&
                _notification.isNotEmpty &&
                _notification[i].status == 'unread') {
            }
          }
        }
      },
  builder: (context, state) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _screens,
      ),
      bottomNavigationBar: Material(
        elevation: 5,
        child: CurvedNavigationBar(
          animationCurve: Curves.linear,
          height: kBottomNavigationBarHeight,
          animationDuration: UiConstants.bottomNavigationBarDuration,
          backgroundColor: Theme.of(context).primaryColor,
          index: _currentIndex,
          onTap: _updatePageViewIndex,
          items: _items(),
        ),
      ),
    );
  },
);
  }

  bool? isFirstTimeLoading;



  Widget _buildBottomNavigationBarIcon({
    required String label,
    required String image,
  }) {
    return SvgPicture.asset(
      image,
    );
  }

  Widget _buildNotificationBarIcon({
    required String label,
    required String image,
  }) =>
      StreamBuilder<Object>(
        stream:
            context.read<ActivityScreenCubit>().countStreamController.stream,
        builder: (context, snapshot) {
          int? _count;
          if (snapshot.hasData) {
            _count = snapshot.data as int?;
          }
          return BadgeCountView(
            count: _count,
            child: _buildBottomNavigationBarIcon(label: label, image: image),
          );
        },
      );

  void _fetchUserNotifications(BuildContext context) {
    BlocProvider.of<ActivityScreenCubit>(context).getInitialNotifications();
  }

  void _handleUriNavigation(Uri? _uri) {
    if (_uri != null && _uri.hasQuery) {
      if (_uri.query.contains('user_id')) {
        _openUserProfileScreen(_uri.queryParameters['user_id']);
      }
      if (_uri.query.contains('place_id')) {
        _openPlaceDetailScreen(_uri.queryParameters['place_id']);
      }
    }
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        debugPrint('got uri: $uri');
        _handleUriNavigation(uri);
      }, onError: (Object err) {
        if (!mounted) return;
        debugPrint('got err in share able link: $err');
      });
    }
  }

  Future<void> _handleInitialUri() async {
    if (!AppData.initialUriIsHandled) {
      AppData.initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri != null) {
          debugPrint('got initial uri: $uri');
          _handleUriNavigation(uri);
        }
        if (!mounted) return;
      } on PlatformException {
        debugPrint('failed to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        debugPrint('got err in share able link: $err');
      }
    }
  }

  List<Widget> _items() => [
        _buildBottomNavigationBarIcon(
            label: "Feed",
            image:
                "assets/icons/fire${_currentIndex == 0 ? '_selected' : ''}.svg"),
        _buildBottomNavigationBarIcon(
            label: "Discover",
            image:
                "assets/icons/discover${_currentIndex == 1 ? '_selected' : ''}.svg"),
        _buildBottomNavigationBarIcon(
            label: "Spot",
            image:
                "assets/icons/spot${_currentIndex == 2 ? '_selected' : ''}.svg"),
        Stack(
          alignment: Alignment.center,
          children: [
            _buildNotificationBarIcon(
              label: "Notifications",
              image:"assets/icons/notifications${_currentIndex == 3 ? '_selected' : ''}.svg",
            ),
            for (int i = 0; i < _notification.length; i++)
              if (_notification.length != 0 &&
                  _notification[i].status == 'unread')
                Container(
                  height: 10,
                  width: 10,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Colors
                        .orange.shade600,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Text(
                        "${foundElements.length}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 5, color: Colors.white),
                      )),
                )
              else
                const SizedBox(),

          ],
        ),
        _buildBottomNavigationBarIcon(
            label: "Profile",
            image:
                "assets/icons/profile${_currentIndex == 4 ? '_selected' : ''}.svg"),
      ];

  void _onPageChanged(int _index) {
    if (_currentIndex != _index) {
      setState(() {
        _currentIndex = _index;
      });
    }
  }

  void _openFeedScreen() {
    print("_open Feed Screen");
    setState(() {
      isFirstTimeLoading = false;
    });
    _updatePageViewIndex(0);
  }

  void _openNewSpotScreen() {
    _updatePageViewIndex(2);
  }

  void _openPlaceDetailScreen(String? _id) {
    if (_id != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlaceDetailScreen(Place(id: _id))));
    }
  }

  void _openUserProfileScreen(String? _id) {
    if (_id != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewProfileScreen(User(id: int.parse(_id)))));
    }
  }

  void _updatePageViewIndex(int _index) {
    _onPageChanged(_index);
    print("_update Page View Index");

    _pageController.animateToPage(
      _index,
      duration: UiConstants.bottomNavigationBarDuration,
      curve: Curves.linear,
    );
  }
}
