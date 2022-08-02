import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/follow_un_follow_cubit/follow_un_follow_cubit.dart'
    hide LoadingState;
import 'package:spott/blocs/view_profile_screen_cubits/view_user_profile_cubit/view_user_profile_cubit.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/feed_screen/chat_screen/chat_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/setting_screen/setting_screen.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/app_tab_bar.dart';
import 'package:spott/ui/ui_components/count_text_view.dart';
import 'package:spott/ui/ui_components/error_view.dart';
import 'package:spott/ui/ui_components/follow_un_follow_button.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/place_card_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

import 'user_followers_screen/user_followers_screen.dart';
import 'user_following_screen/user_following_screen.dart';
import 'user_spotted_posts_screen/user_spotted_posts_screen.dart';

enum MenuOption { blockUser }

class ViewProfileScreen extends StatefulWidget {
  final User? _user;

  const ViewProfileScreen(this._user, {Key? key}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _FollowButton extends StatelessWidget {
  final User? _user;

  const _FollowButton(this._user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return BlocListener<FollowUnFollowCubit, FollowUnFollowState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context: context, message: state.message);
        } else if (state is UserFollowedSuccessfully) {
          showSnackBar(
              context: context,
              message: LocaleKeys.followRequestIsPending.tr());
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _screenWidth / 8),
        child: AppButton(
          text: LocaleKeys.follow.tr(),
          onPressed: () {
            context.read<FollowUnFollowCubit>().followUser(_user?.id);
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _ViewProfileScreenState extends State<ViewProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ViewProfileApiResponse? _apiResponse;
  bool _isOtherUserProfile = true;

  ScrollController scrollController = ScrollController();
  bool visibilityOfTitle = false;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          setState(() {
            visibilityOfTitle = false;
          });
        } else {
          setState(() {
            visibilityOfTitle = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<ViewUserProfileCubit>(
        //   create: (context) =>
        //       ViewUserProfileCubit()..viewUserProfile(widget._user?.id),
        // ),
        BlocProvider<FollowUnFollowCubit>(
          create: (context) => FollowUnFollowCubit(),
        ),
      ],
      child: BlocConsumer<ViewUserProfileCubit, ViewUserProfileState>(
          listener: (context, state) {
        if (state is FailedToFetchProfileState) {
          if (state.message != null) {
            showSnackBar(context: context, message: state.message!);
          }
        } else if (state is FailedState) {
          if (state.message != null) {
            showSnackBar(context: context, message: state.message!);
          }
        } else if (state is FetchedViewUserProfile) {
          _apiResponse = state.apiResponse;
          checkChatIsActiveOrNot();
        } else if (state is UserBlocked) {
          if (state.apiResponse.message != null) {
            showSnackBar(context: context, message: state.apiResponse.message!);
          }
        } else if (state is UserShareLinkFetched) {
          shareUserProfileLink(state.link);
        }
      }, builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        final bool _canSeeUserProfile =
            _apiResponse?.profile?.type == ProfileType.public ||
                (_apiResponse?.profile?.isFollower == null ? false : true);
        _isOtherUserProfile = _apiResponse?.profile?.id != null &&
            _apiResponse!.profile!.id! != AppData.currentUser?.id;
        return Scaffold(
          body: (state is FailedToFetchProfileState)
              ? Center(
                  child: ErrorView(
                    onRetryPressed: () => _fetchUserProfile(context),
                  ),
                )
              : _apiResponse == null
                  ? const SizedBox()
                  : NestedScrollView(
                      controller: scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            title: Text(
                              _apiResponse?.profile?.username != null
                                  ? '${_apiResponse?.profile?.username.toString().substring(0, 1).toUpperCase()}' +
                                      '${_apiResponse?.profile?.username.toString().substring(1)}'
                                  : '',
                              style: TextStyle(
                                  fontSize: size.width * 0.043,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                            expandedHeight: 250,
                            stretch: true,
                            pinned: true,
                            actions: [
                              IconButton(
                                onPressed: () => _onShareButtonPressed(context),
                                icon: const Icon(Icons.share),
                              ),
                              if (_isOtherUserProfile)
                                PopupMenuButton(
                                  onSelected: (MenuOption value) =>
                                      _onPopupMenuSelection(context, value),
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        value: MenuOption.blockUser,
                                        child: Text(
                                          LocaleKeys.blockUser.tr(),
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      ),
                                    ];
                                  },
                                  child: const Icon(
                                    Icons.more_vert,
                                    size: 35,
                                  ),
                                )
                              else
                                IconButton(
                                  onPressed: _openSettingsScreen,
                                  icon: const Icon(
                                    Icons.settings,
                                  ),
                                ),
                            ],
                            flexibleSpace: FlexibleSpaceBar(
                              background: _buildCoverImageView(),
                              centerTitle: true,
                              stretchModes: const [
                                StretchMode.zoomBackground,
                                StretchMode.blurBackground,
                                StretchMode.fadeTitle,
                              ],
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                _buildProfileListTile(size),
                                const Divider(
                                  height: 30,
                                  thickness: 1,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        LocaleKeys.about.tr(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _apiResponse?.profile?.bio ?? '',
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_canSeeUserProfile)
                            SliverPersistentHeader(
                              delegate: _SliverAppBarDelegate(
                                AppTabBar(
                                  _tabController,
                                  icons: const [
                                    "assets/icons/fire_selected.svg",
                                    "assets/icons/building_selected.svg"
                                  ],
                                ),
                              ),
                              pinned: true,
                            ),
                        ];
                      },
                      body: Container(
                        color: AppColors.secondaryBackGroundColor,
                        child: _canSeeUserProfile
                            ? TabBarView(
                                controller: _tabController,
                                children: [
                                  _buildUserPostsListView(),
                                  _buildUserPlacesListView(),
                                ],
                              )
                            : _buildProfileIsPrivateView(),
                      ),
                    ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool chatIsGoingOn = false;

  @override
  void initState() {
    context.read<ViewUserProfileCubit>().viewUserProfile(widget._user!.id);
    setupScrollController(context);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _buildCoverImageView() => _apiResponse?.profile?.coverPicture != null
      ? CachedNetworkImage(
          imageUrl: _apiResponse!.profile!.coverPicture!,
          fit: BoxFit.cover,
          placeholder: (_, __) => const SizedBox(
            height: 50,
            child: LoadingAnimation(),
          ),
          errorWidget: (_, __, ___) => Container(
            color: Colors.grey,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/icons/no_image.svg",
              width: 50,
              height: 50,
            ),
          ),
        )
      : Container(
          color: Colors.grey,
          alignment: Alignment.center,
          child: SvgPicture.asset(
            "assets/icons/no_image.svg",
            width: 50,
            height: 50,
          ),
        );

  Widget _buildNoPlacesView() {
    return Center(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll!.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/icons/no_place.svg'),
              const SizedBox(
                height: 30,
              ),
              Text(
                LocaleKeys.noFavouritePlaces.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoPostsView() {
    return Center(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll!.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/empty_state.svg'),
              const SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  // 'No Spott added by ${_apiResponse?.profile?.username ?? ''}',
                  LocaleKeys.noSpottAddedBy.tr()+'  ${_apiResponse?.profile?.username ?? ''}',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileIsPrivateView() {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset('assets/icons/private_account.svg'),
              const SizedBox(
                height: 30,
              ),
              Text(
                LocaleKeys.privateAccount.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
              if (_apiResponse?.profile?.id != null &&
                  _apiResponse!.profile!.id! != AppData.currentUser?.id)
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _screenWidth / 10),
                      child: Text(
                        LocaleKeys
                            .followThisAccountToSeeTheirSpotsAndFavouritePlaces
                            .tr(),
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _FollowButton(_apiResponse?.profile)
                  ],
                ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileListTile(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            _apiResponse?.profile?.username ?? '',
            style: TextStyle(
                fontSize: size.width * 0.054, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _apiResponse?.profile?.name ?? '',
            style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.035,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          leading: UserProfileImageView(_apiResponse?.profile),
          trailing: _isOtherUserProfile
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if ((_apiResponse?.profile?.isFollower == null
                            ? false
                            : true) ||
                        _apiResponse?.profile?.type == ProfileType.public)
                      IconButton(
                        onPressed: () => _openChat(context),
                        icon: SvgPicture.asset(
                          "assets/icons/start_chat.svg",
                          color: chatIsGoingOn ? null : Colors.grey,
                        ),
                        iconSize: 50,
                        padding: EdgeInsets.zero,
                      ),
                    FollowUnFollowButton(
                      _apiResponse?.profile,
                      updateParent: () {
                        setState(() {});
                      },
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        const Divider(
          height: 30,
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: _openFollowersScreen,
              child: Column(
                children: [
                  Text(
                    LocaleKeys.follower.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  CountTextView(
                    _apiResponse?.profile?.followersCount,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _openSpottedPostsScreen,
              child: Column(
                children: [
                  Text(
                    LocaleKeys.spotted.tr(),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.purple,
                        ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  CountTextView(_apiResponse?.profile?.spotsCount,
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            GestureDetector(
              onTap: _openFollowingScreen,
              child: Column(
                children: [
                  Text(
                    LocaleKeys.following.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  CountTextView(_apiResponse?.profile?.followingCount,
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> checkChatIsActiveOrNot() async {
    try {
      final Future<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
          .instance
          .collection('messages')
          .doc(AppData.currentUser!.id.toString())
          .collection(_apiResponse!.profile!.id.toString())
          .get();
      data.then((value) {
        print(
          value.docs.where(
            (element) {
              print('${element.get('receiver')}  ' +
                  '  ${_apiResponse!.profile!.id.toString()}');
              if (element.get('receiver') ==
                  _apiResponse!.profile!.id.toString()) {
                setState(() {
                  chatIsGoingOn = true;
                });
                return true;
              } else {
                return false;
              }
            },
          ),
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildUserPlacesListView() {
    return (_apiResponse?.places != null && _apiResponse!.places!.isNotEmpty)
        ? ListView.separated(
            itemCount: _apiResponse!.places!.length,
            itemBuilder: (context, index) =>
                PlaceCardView(_apiResponse!.places![index],index),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          )
        : _buildNoPlacesView();
  }

  Widget _buildUserPostsListView() {
    return (_apiResponse?.posts != null && _apiResponse!.posts!.isNotEmpty)
        ? ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: _apiResponse!.posts!.length,
            itemBuilder: (context, index) =>
                PostCardView(index),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          )
        : _buildNoPostsView();
  }

  void _fetchUserProfile(BuildContext context) {
    context.read<ViewUserProfileCubit>().viewUserProfile(widget._user?.id);
  }

  void _onPopupMenuSelection(BuildContext context, MenuOption value) {
    try {
      switch (value) {
        case MenuOption.blockUser:
          context.read<ViewUserProfileCubit>().blockUser(widget._user?.id);
          FirebaseFirestore.instance
              .collection('messages')
              .doc(AppData.currentUser!.id.toString())
              .collection('contacts')
              .doc(widget._user!.id.toString())
              .delete();
          FirebaseFirestore.instance
              .collection('messages')
              .doc(widget._user!.id.toString())
              .collection('contacts')
              .doc(AppData.currentUser!.id.toString())
              .delete();
          Navigator.pop(context);
          break;
      }
    } catch (e) {}
  }

  void _onShareButtonPressed(BuildContext context) {
    context.read<ViewUserProfileCubit>().getShareAbleLink(widget._user?.id);
  }

  Future<void> _openChat(BuildContext context) async {
    if (_apiResponse?.profile != null) {
      checkChatIsActiveOrNot();

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatScreenWithUser(
            viewProfileApiResponse: _apiResponse,
            receiverId: _apiResponse!.profile!.id,
            receiverName: _apiResponse!.profile!.username,
          ),
        ),
      );
    }
  }

  void _openFollowersScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserFollowersScreen(widget._user),
      ),
    );
  }

  void _openFollowingScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserFollowingScreen(widget._user),
      ),
    );
  }

  void _openSettingsScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    );
  }

  void _openSpottedPostsScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => UserSpottedPostsScreen(widget._user)),
    );
  }
}
