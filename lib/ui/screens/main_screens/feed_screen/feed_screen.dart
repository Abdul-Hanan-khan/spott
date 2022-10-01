import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/statics.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/app_button.dart';
import 'package:spott/ui/ui_components/error_view.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/no_gps_error.dart';
import 'package:spott/ui/ui_components/no_posts.dart';
import 'package:spott/ui/ui_components/stories_list_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import '../../../../variables.dart';
import '../../../ui_components/post_card_view.dart';
import '../../../ui_components/post_card_view_detail.dart';
import 'chat_screen/list_of_chat_users.dart';

class FeedScreen extends StatefulWidget {
  final bool isSplash;
  final Function _openNewSpot;
  final bool isFirstTimeLoading;

  const FeedScreen(this.isSplash, this._openNewSpot, {Key? key, this.isFirstTimeLoading = true}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with AutomaticKeepAliveClientMixin {
  Completer<void>? _refreshCompleter;
  final List<List<Post>> _stories = [];
  ScrollController scrollControllerNested = ScrollController();
  ScrollController scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          loadMorePost(context);
        } else {
          scrollControllerNested.jumpTo(0);
        }
      } else {
        scrollControllerNested.animateTo(
          scrollControllerNested.position.maxScrollExtent,
          duration: const Duration(milliseconds: 130),
          curve: Curves.slowMiddle,
        );
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  bool locationIsOn = true;

  @override
  Widget build(BuildContext context) {
    // List<Post> _postTemp= context.read<FeedCubit>().posts;
    print('feed screen ////////////////////////////////////////////////');
    super.build(context);
    return BlocConsumer<FeedCubit, FeedCubitState>(
      listener: (context, state) {
        if (state is ErrorState) {
          showSnackBar(context: context, message: state.message);
          _stopPullToRefreshLoader();
        } else if (state is PostsFetchedSuccessfully) {
          _stopPullToRefreshLoader();
        } else if (state is StoriesFetchedSuccessfully) {
          _stopPullToRefreshLoader();
          if (state.apiResponse.data != null) {

            _stories.clear();
            _stories.addAll(state.apiResponse.data as List<List<Post>>);
            // print(_stories[0][0].seenn);
            // _postTemp.forEach((element) {
            //   element.storySeenn=_stories[0][0].seenn;
            // });

          }
        }
      },
      // buildWhen: (oldState, currentState) {
      //   if (currentState is PostCardSuccessStates ||
      //       currentState is PostCardLoadingStates ||
      //       currentState is StoriesFetchedSuccessfully ||
      //       currentState is LoadingStories) {
      //     return false;
      //   } else {
      //     return true;
      //   }
      // },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        return LoadingScreenView(
          isLoading: state is LoadingInitialData,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.feed.tr(),
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: size.width * 0.045),
              ),
              actions: [
                IconButton(
                  icon: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users').doc(AppData.currentUser!.id.toString()).snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      try {
                        print("is new message => ${snapshot.data!['isNewMessage']}");
                        if (snapshot.hasData) {
                          if ((snapshot.data!['isNewMessage'] as int) == 1) {
                            return Stack(
                              // overflow: Overflow.visible,
                              children: [
                                SvgPicture.asset('assets/icons/message.svg'),
                                Positioned(
                                  left: 12,
                                  bottom: 11,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.orange.shade600),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return SvgPicture.asset('assets/icons/message.svg');
                          }
                        } else {
                          return SvgPicture.asset('assets/icons/message.svg');
                        }
                      } catch (e) {
                        return SvgPicture.asset('assets/icons/message.svg');
                      }
                    },
                  ),
                  onPressed: _openChatScreen,
                ),
              ],
            ),
            backgroundColor: AppColors.secondaryBackGroundColor,
            body: RefreshIndicator(
              notificationPredicate: (notification) {
                return notification.depth == 1;
              },
              onRefresh: () => _onRefresh(context),
              child: NestedScrollView(
                controller: scrollControllerNested,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(child: StoriesListView(_stories)),
                  ];
                },
                body: (state is GPSNoState)
                    ? NoGpsErrorView(
                        onGpsLocationButton: () => turnOnGpsLocation(context),
                      )
                    : (state is NoPostState)
                        ? NoPostView(
                            onGpsLocationButton: () => turnOnGpsLocation(context),
                          )
                        : (state is ErrorState)
                            ? ErrorView(
                                onRetryPressed: () => _getInitialData(context),
                              )
                            : (state is PostsFetchedSuccessfully && context.read<FeedCubit>().posts.isEmpty)
                                ? _buildNoPostView(context)
                                : _buildPostsListView(context),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print("User id => ${AppData.currentUser!.id}");
    _refreshCompleter = Completer<void>();

    if(!widget.isSplash){
      _getInitialData(context);
    }
    Future.delayed(Duration(seconds: 0),(){
      loadMorePost(context);
    });
    setupScrollController(context);
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppData.currentUser!.id.toString())
        .set({'userState': 0, 'isNewMessage': 0});


    // checkUser();
  }

  void checkUser() async {
    if (AppData.currentUser!.id != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: AppData.currentUser!.id).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance.collection('users').doc(AppData.currentUser!.id.toString()).set({'id': AppData.currentUser!.id});
      }
    }
  }

  Widget _buildNoPostView(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/empty_state.svg'),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.noSpotsNearYou.tr(),
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 10),
            child: Text(
              LocaleKeys.leaveALivePostWeWillSendANotificationToAllThePeopleAroundYou.tr(),
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _screenWidth / 8),
            child: AppButton(
              text: LocaleKeys.newSpot.tr(),
              onPressed: _openNewSpotScreen,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Future<void> loadMorePost(BuildContext context) async {
    Position? value=StaticVars.userPosition;
    final bool isAccepted = await checkLocationPermission();

    if (isAccepted) {
      setState(() {
        locationIsOn = true;
      });


        if (value != null && value.longitude != null) {
          BlocProvider.of<FeedCubit>(context).getAllData(
            isFirstTimeLoading: false,
            context: context,
            position: value,
          );
        } else {
          showSnackBar(context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
        }



    } else {
      setState(() {
        locationIsOn = false;
      });
    }
  }

  ListView _buildPostsListView(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: context.read<FeedCubit>().posts.length,
      itemBuilder: (context, index) {
        return PostCardView(index);
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
    );
  }

  void _getInitialData(BuildContext context) async {
    final bool isAccepted = await checkLocationPermission();

    if (isAccepted) {
      setState(() {
        locationIsOn = true;
      });

      await getUserLatLng(context).then((value) {
        StaticVars.userPosition=value;
        if (value != null && value.longitude != null) {
          context.read<FeedCubit>().getAllData(position: position);
        } else {
          showSnackBar(context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
        }
      }).whenComplete(() {});
    } else {
      setState(() {
        locationIsOn = false;
      });
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<FeedCubit>().refreshAllData(context);
    return _refreshCompleter?.future;
  }

  void _openChatScreen() {
    // print("Token => ${AppData.currentUser!.id}");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ListOfChatUsers(),
      ),
    );
  }

  void _openNewSpotScreen() {
    widget._openNewSpot();
  }

  void _stopPullToRefreshLoader() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Future<bool> checkLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      return true;
    } else {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }

  turnOnGpsLocation(BuildContext context) async {
    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      _getInitialData(context);
    } else {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return false;
        } else {
          _getInitialData(context);
        }
      } else {
        _getInitialData(context);
      }
    }
  }
}
