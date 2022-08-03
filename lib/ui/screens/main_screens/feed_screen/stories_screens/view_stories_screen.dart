import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/blocs/stories_cubits/view_stories_cubit/view_stories_cubit.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/feed_screen/chat_screen/chat_screen.dart';
import 'package:spott/ui/screens/main_screens/feed_screen/chat_screen/chats_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_detail_screen/place_detail_screen.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/enums.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'package:story_view/story_view.dart';

class ViewStoriesScreen extends StatefulWidget {
  final List<Post> allStories;
  final Post story;
  const ViewStoriesScreen(
      {required this.allStories, required this.story, Key? key})
      : super(key: key);

  @override
  _ViewStoriesScreenState createState() => _ViewStoriesScreenState();
}

class _FooterView extends StatelessWidget {
  final Post? _currentStory;


  const _FooterView(
    this._currentStory, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var timeStamp=  getStringFromTime(_currentStory!.createdAt);

    final Size _screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            InkWell(
              onTap: () => _onUserNameTap(context),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: _screenSize.width / 20),
                    child: UserProfileImageView(_currentStory?.user),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _screenSize.width / 50),
                    child: Text(
                      _currentStory?.user?.username ?? '',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            if (_currentStory?.createdAt != null)
              Text(
            timeStamp['postTime'].toString()+timeStamp['postSymbol'].toString().tr()
              ),
            const Spacer(),
            if (isNotCurrentUser(_currentStory?.user?.id))
              Row(
                children: [
                  BlocBuilder<ViewStoriesCubit, ViewStoriesCubitState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => _onSpottButtonPressed(context),
                        child: SvgPicture.asset(
                          _currentStory?.spot?.status == SpotStatus.accept
                              ? 'assets/icons/eye_accepted.svg'
                              : 'assets/icons/eye.svg',
                          color:
                              _currentStory?.spot == null ? Colors.black : null,
                          height: 20,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => _openChatScreen(context),
                    child: SvgPicture.asset(
                      'assets/icons/add_post.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  PopupMenuButton(
                    onSelected: (PopMenuOption value) =>
                        _onPopupMenuSelection(context, value),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: PopMenuOption.reportPost,
                          child: Text(LocaleKeys.reportThisMoment.tr()),
                        ),
                        PopupMenuItem(
                          value: PopMenuOption.blockUser,
                          child: Text(
                            LocaleKeys.blockUser.tr(),
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ];
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: SvgPicture.asset(
                        'assets/icons/more.svg',
                        width: _screenSize.width * 0.02,
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

  void _onPopupMenuSelection(BuildContext context, PopMenuOption value) {
    switch (value) {
      case PopMenuOption.reportPost:
        context
            .read<ViewStoriesCubit>()
            .reportStory(int.parse(_currentStory!.id.toString()));
        break;
      case PopMenuOption.blockUser:
        context.read<ViewStoriesCubit>().blockUser(_currentStory?.user?.id);
        break;
    }
  }

  void _onSpottButtonPressed(BuildContext context) {
    context
        .read<ViewStoriesCubit>()
        .requestSpot(int.parse(_currentStory!.id.toString()));
  }

  void _onUserNameTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewProfileScreen(_currentStory?.user),
      ),
    );
  }

  void _openChatScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreenWithUser(
          receiverName: _currentStory!.user!.username,
          receiverId: _currentStory!.user!.id,
          viewProfileApiResponse: ViewProfileApiResponse(
              profile: User(username: _currentStory!.user!.username)),
        ),
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  final List<Post> allStories;
  final PageController controller;
  final Post? currentPost;
  const _HeaderView(
      {required this.allStories,
      required this.controller,
      required this.currentPost,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 50,
        width: double.infinity,
        color: Colors.white,
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: allStories.length,
          controller: controller,
          itemBuilder: (context, index) {
            final Post story = allStories[index];
            final bool _isShowing = currentPost == story;
            return InkWell(
              onTap: story.place != null
                  ? () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PlaceDetailScreen(story.place!)));
                    }
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/building.svg',
                    color: _isShowing ? Theme.of(context).primaryColor : null,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(story.place?.name ?? '',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: _isShowing
                                    ? Theme.of(context).primaryColor
                                    : null)),
                        Text(
                          story.place?.fullAddress ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  fontSize: 12,
                                  color: _isShowing
                                      ? Theme.of(context).primaryColor
                                      : null),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ViewStoriesScreenState extends State<ViewStoriesScreen> {
  bool _isFirstTimeRunning =
      true; //! to check if the stories is running for the first time or user came form 2nd story to 1 first story (this use to fix issue in plugin)
  final StoryController _storiesController = StoryController();
  final PageController _headerPageController = PageController(
    viewportFraction: 0.5,
  );
  final List<StoryItem> _storyItems = [];
  Post? _currentStory;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewStoriesCubit, ViewStoriesCubitState>(
      listener: (context, state) {
        if (state is FailedState && state.message != null) {
          showSnackBar(context: context, message: state.message!);
        }
        if (state is UserBlocked) {
          if (state.apiResponse.message != null) {
            showSnackBar(context: context, message: state.apiResponse.message!);
          }
        }
        if (state is StoryReported) {
          if (state.apiResponse.message != null) {
            showSnackBar(context: context, message: state.apiResponse.message!);
          }
        }
        if (state is SpottRequestStatusUpdated) {
          _currentStory?.updateSpotStatus(state.spot);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            _HeaderView(
              controller: _headerPageController,
              allStories: widget.allStories,
              currentPost: _currentStory,
            ),
            Expanded(
              child: (_storyItems.isNotEmpty)
                  ? StoryView(
                      storyItems: _storyItems,
                      controller: _storiesController,
                      indicatorColor: Theme.of(context).primaryColor,
                      onComplete: _closeScreen,
                      onVerticalSwipeComplete: (v) {
                        if (v == Direction.down) {
                          _closeScreen();
                        }
                      },
                      onStoryShow: _onStoryShow,
                    )
                  : const SizedBox(),
            ),
            _FooterView(_currentStory),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _storiesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _currentStory = widget.allStories.first;

    for (final story in widget.allStories) {
      if (story.type == PostType.image) {
        _storyItems.add(
          StoryItem.pageImage(
            url: story.media?.first ?? '',
            controller: _storiesController,
            duration: const Duration(
              seconds: 15,
            ),
          ),
        );
      }

      if (story.type == PostType.video) {
        _storyItems.add(
          StoryItem.pageVideo(story.media?.first ?? '',
              controller: _storiesController),
        );
      }
    }
  }

  void _closeScreen() async{


    await getUserLatLng(context).then((value) {
      if (value != null && value.longitude != null) {
        BlocProvider.of<FeedCubit>(context).getAllData(
          isFirstTimeLoading: false,
          context: context,
          position: value,
        );
      } else {
        showSnackBar(context: context, message: LocaleKeys.pleaseTurnOnYourLocation.tr());
      }
    }).whenComplete(() {});


    // getUserLatLng(context).then((value) {
    //   context.read<FeedCubit>().getAllStories(
    //         data: FormData.fromMap(
    //           {'lat': value!.latitude, 'lng': value.longitude},
    //         ),
    //       );
    // });

    Navigator.of(context).pop();
  }

  void _markStoryAsSeen(Post story) {
    if (!(story.seenn ?? false)) {
      context
          .read<ViewStoriesCubit>()
          .markStoryAsSeen(int.parse(story.id.toString()));
    }
  }

  void _onStoryShow(StoryItem _currentStoryItem) {
    final _story = widget.allStories.elementAt(
      _storyItems.indexOf(_currentStoryItem),
    );
    _markStoryAsSeen(_story);
    if (!_isFirstTimeRunning) {
      setState(() {
        _currentStory = _story;
      });
      _headerPageController.animateToPage(
          _storyItems.indexOf(_currentStoryItem),
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear);
    } else {
      _isFirstTimeRunning = false;
    }
  }
}
