import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart'
    hide ErrorState;
import 'package:spott/blocs/place_stories_cubit/place_stories_cubit.dart';
import 'package:spott/blocs/stories_cubits/view_stories_cubit/view_stories_cubit.dart';
import 'package:spott/models/api_responses/place_stories_api_response.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/utils/enums.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:story_view/story_view.dart';

import '../../../../utils/show_snack_bar.dart';

class UserViewStoriesScreen extends StatefulWidget {
  const UserViewStoriesScreen(this.id, this.name, this.postId,{Key? key}) : super(key: key);

  final String id;
  final String name;
  final int postId;

  @override
  _UserViewStoriesScreenState createState() => _UserViewStoriesScreenState();
}

class _FooterView extends StatelessWidget {
  final Stories? _currentStory;

  const _FooterView(
      this._currentStory, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                // _onUserNameTap(context);
              },
              child: Row(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(left: _screenSize.width / 20),
                  //   child: UserProfileImageView(_currentStory?.user),
                  // ),
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
                getStringFromTime(DateTime.tryParse(_currentStory!.createdAt!)),
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
                  SvgPicture.asset(
                    'assets/icons/add_post.svg',
                    width: 25,
                    height: 25,
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

// void _onUserNameTap(BuildContext context) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (context) => ViewProfileScreen(_currentStory?.user),
//     ),
//   );
// }
}

class _HeaderView extends StatelessWidget {
  final List<Stories> stories;
  final PageController controller;
  final Stories? currentPost;
  final String name;

  const _HeaderView(
      {required this.stories,
        required this.controller,
        required this.currentPost,
        required this.name,
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
          itemCount: stories.length,
          controller: controller,
          itemBuilder: (context, index) {
            final Stories story = stories[index];
            final bool _isShowing = currentPost == story;
            return Row(
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
                      Text(name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: _isShowing
                                  ? Theme.of(context).primaryColor
                                  : null)),
                      Text(
                        story.address ?? '',
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
            );
          },
        ),
      ),
    );
  }
}

class _UserViewStoriesScreenState extends State<UserViewStoriesScreen> {
  bool _isFirstTimeRunning =
  true; //! to check if the stories is running for the first time or user came form 2nd story to 1 first story (this use to fix issue in plugin)
  final StoryController _storiesController = StoryController();
  final PageController _headerPageController = PageController(
    viewportFraction: 0.5,
  );
  final List<StoryItem> _storyItems = [];
  final List<Stories> allStories = [];
  Stories? _currentStory;


  @override
  Widget build(BuildContext context) {

    print("\n\n\nn\n\n");
    print(widget.postId);
    print("\n\n\nn\n\n");
    // _post = context.read<FeedCubit>().posts[index];
    return BlocProvider(
      create: (context) =>
      PlaceStoriesCubit()..getAllPosts(id: widget.id.toString()),
      // context.read<PlaceStoriesCubit>().getAllPosts(id: widget.id.toString()),
      child: BlocConsumer<PlaceStoriesCubit, PlaceStoriesState>(
        listener: (context, state) {
          if (state is ErrorState) {}
          if (state is FetchedUserPostsSuccessfully) {
            allStories.clear();
            allStories.addAll(state.stories!);
            if(allStories.isEmpty){
              Navigator.pop(context);
            }
            _currentStory = allStories.first;
            print(_currentStory?.media?.first);



            for (final story in allStories) {
              if (story.type == "image") {
                print("...........${story.type}");
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
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is LoadingData,
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Column(
                children: [
                  _HeaderView(
                    controller: _headerPageController,
                    stories: allStories,
                    currentPost: _currentStory,
                    name: widget.name,
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
        },
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
    Navigator.of(context).pop();
  }

  // void _markStoryAsSeen(Post story) {
  //
  //   context.read<ViewStoriesCubit>().markStoryAsSeen(int.parse(story.id.toString()));
  // }

  void _onStoryShow(StoryItem _currentStoryItem) async{
    final Stories _story = allStories.elementAt(
      _storyItems.indexOf(_currentStoryItem),
    );
    await context
        .read<ViewStoriesCubit>()
        .markPostAsSeen(widget.postId);
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
