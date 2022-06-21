import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/post_card_view_cubit/post_card_view_cubit.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/feed_screen/user_view_stories_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_detail_screen/place_detail_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/post_interaction_screens/comments_screen/comments_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/post_interaction_screens/post_interaction_screen/post_interaction_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/post_interaction_screens/spotted_requests_screen/spotted_requests_screen.dart';
import 'package:spott/ui/screens/main_screens/other_screens/post_view_screen/post_view_screen.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/count_text_view.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:spott/ui/ui_components/place_image_view.dart';
import 'package:spott/ui/ui_components/spott_dialog_boxes.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/ui/ui_components/video_widget.dart';
import 'package:spott/utils/enums.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/preferences_controller.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../../blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart' hide PostLiked, PostDisliked, ErrorState, CommentCountUpdated;

class PostCardView extends StatefulWidget {
  final bool addNavigationToComments;
  final int index;


   PostCardView(
     this.index, {

    this.addNavigationToComments = true,
  }) ;

  @override
  State<PostCardView> createState() => _PostCardViewState();
}

class _PostCardViewState extends State<PostCardView> {
  bool postIsVisible = true;

  changePostVisibility(bool postIsVisible) {
    setState(() {
      this.postIsVisible = !postIsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    Post _post=context.read<FeedCubit>().posts[widget.index];
    return postIsVisible
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _PostHeaderView(
                    index: widget.index,
                    post: _post,
                    onVisibilityChange: changePostVisibility,
                  ),
                  if (_post.type == PostType.image && _post.media?.first != null)
                    InkWell(
                      onTap: () {
                        openDetailViewScreen(context);
                      },
                      child: Container(
                        constraints: const BoxConstraints(
                          maxHeight: 600,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: _post.media?.first ?? '',
                          fit: BoxFit.fitWidth,
                          placeholder: (context, url) => const SizedBox(
                            height: 150,
                            child: LoadingAnimation(),
                          ),
                          errorWidget: (context, url, error) => const SizedBox(
                            height: 150,
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  if (_post.type == PostType.video && _post.media?.first != null) VideoWidget(videoUrl: _post.media?.first),
                  InkWell(
                    onTap: () {
                      openDetailViewScreen(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(_post.content ?? ''),
                    ),
                  ),
                  _buildUserProfile(context),
                  const Divider(),
                  _PostFooterView(
                    widget.index,
                    addNavigationToComments: widget.addNavigationToComments,
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  void openDetailViewScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          widget.index
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    Post _post=context.read<FeedCubit>().posts[widget.index];

    return ListTile(
      onTap: context.read<FeedCubit>().posts[widget.index].user != null
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ViewProfileScreen(_post.user),
                ),
              );
            }
          : null,
      leading: InkWell(
          onTap: () {
            if (_post.user?.storyAvailable == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserViewStoriesScreen(_post.placeId, _post.place!.name!, _post.id),
                  ));
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  border: (_post.user?.storyAvailable == true)
                      ? _post.isSeen == false
                          ? Border.all(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 2.0,
                            )
                          : Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 2.0,
                            )
                      : null,
                  borderRadius: BorderRadius.circular(25)),
              child: UserProfileImageView(_post.user))),
      title: Text(
        _post.user?.username ?? '',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.7),
          fontSize: MediaQuery.of(context).size.width * 0.037,
        ),
      ),
      trailing: (_post.createdAt != null)
          ? Text(
              getStringFromTime(_post.createdAt),
              style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
            )
          : null,
    );
  }
}

class _PostFooterView extends StatefulWidget {

  final bool addNavigationToComments;
  final int index;

   _PostFooterView(
    this.index,{
    Key? key,
    required this.addNavigationToComments,
  }) : super(key: key);

  @override
  _PostFooterViewState createState() => _PostFooterViewState();
}

class _PostFooterViewState extends State<_PostFooterView> {
  Reaction? _reaction;

  Reaction selectedReactionWidget(int index, Size size) {
    switch (index) {
      case 0:
        return Reaction(
          icon: Container(
              width: size.width * 0.1,
              height: size.height * 0.03,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Image.asset("assets/reactions/double_arrow_up_icon.gif")),
          previewIcon: Container(
            width: size.width * 0.12,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset("assets/reactions/double_arrow_up_icon.gif"),
          ),
        );
      case 1:
        return Reaction(
          icon: Container(
              width: size.width * 0.1,
              height: size.height * 0.03,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Image.asset('assets/reactions/double_arrow_down_icon.gif')),
          previewIcon: Container(
            width: size.width * 0.12,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/double_arrow_down_icon.gif'),
          ),
        );
      case 2:
        return Reaction(
          icon: Container(
              width: size.width * 0.1,
              height: size.height * 0.03,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Image.asset('assets/reactions/haha2.png')),
          previewIcon: Container(
            width: size.width * 0.1,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/haha.gif'),
          ),
        );
      case 3:
        return Reaction(
          icon: Container(
              width: size.width * 0.1,
              height: size.height * 0.03,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Image.asset('assets/reactions/wow2.png')),
          previewIcon: Container(
            width: size.width * 0.08,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/wow.gif'),
          ),
        );
      case 4:
        return Reaction(
          icon: Container(
              width: size.width * 0.1,
              height: size.height * 0.03,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Image.asset('assets/reactions/sad2.png')),
          previewIcon: Container(
            width: size.width * 0.1,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/sad2.gif'),
          ),
        );
      case 5:
        return Reaction(
          icon: Container(
            width: size.width * 0.1,
            height: size.height * 0.03,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/angry2.png'),
          ),
          previewIcon: Container(
            width: size.width * 0.1,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/angry.gif'),
          ),
        );
      case -1:
        return Reaction(
          icon: Container(
            width: size.width * 0.1,
            height: size.height * 0.03,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/double_arrow_up_icon.gif'),
          ),
          previewIcon: Container(
            width: size.width * 0.12,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/double_arrow_up_icon.gif'),
          ),
        );
      case 10:
        return Reaction(
          icon: Container(
            width: size.width * 0.1,
            height: size.height * 0.03,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset(
              "assets/reactions/double_up_arrow_grey.png",
              color: Colors.grey,
            ),
          ),
          previewIcon: Container(
            width: size.width * 0.12,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset("assets/reactions/double_up_arrow_grey.png"),
          ),
        );
      default:
        return Reaction(
          icon: Container(
            width: size.width * 0.1,
            height: size.height * 0.03,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/double_arrow_up_icon.gif'),
          ),
          previewIcon: Container(
            width: size.width * 0.1,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
            child: Image.asset('assets/reactions/double_arrow_up_icon.gif'),
          ),
        );
    }
  }

  bool isSet = false;
  int value = 0;
  bool isLiked = false;
  bool reactIsRemoved = false;
  bool reacted = false;

  @override
  void initState() {
    Post _post=context.read<FeedCubit>().posts[widget.index];

    super.initState();
    reactIsRemoved = _post.isReacted == null ? true : false;
    reacted = _post.isReacted == null ? false : true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Post _post=context.read<FeedCubit>().posts[widget.index];

    final Size size = MediaQuery.of(context).size;
    if (reactIsRemoved) {
      _post.isReactedd=Is_reacted(id: 0,refId: 0,reactKey: 10,);
      print(_post.isReactedd);
      _reaction = selectedReactionWidget(10, size);
      // _post.isReactedd!.reactKeyy!=10;

      setState(() {});
    }else{
      _reaction = selectedReactionWidget(_post.isReactedd!.reactKeyy, size);

    }

    return BlocConsumer<PostCardViewCubit, PostCardViewState>(
      listenWhen: (oldState, currentState) {
        if (oldState.postId == _post.id || currentState.postId == _post.id) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state.postId == _post.id) {
          if (widget.addNavigationToComments) {
            if (state is PostLiked) {
              _post.postLiked();
            }
            if (state is PostDisliked) {
              _post.postDisliked();
            }
            if (state is SpottRequestStatusUpdated) {
              _post.updateSpotStatus(state.spot);
            }
            if (state is CommentCountUpdated) {
              _post.updatedCommentCount();
            }
          }
          if (state is ErrorState) {
            showSnackBar(context: context, message: state.message);
          }
          if (state is UserBlocked) {
            if (state.apiResponse.message != null) {
              showSnackBar(context: context, message: state.apiResponse.message!);
            }
          }
          if (state is PostReported) {
            if (state.apiResponse.message != null) {
              showSnackBar(context: context, message: state.apiResponse.message!);
            }
          }
        }
      },
      buildWhen: (oldState, currentState) {
        if (oldState.postId == _post.id || currentState.postId == _post.id) {
          return true;
        }
        return false;
      },
      builder: (context, state) {

        if (_post.isReactedd != null) {
          _reaction = selectedReactionWidget(
            int.parse(_post.isReactedd!.reactKeyy!.toString()),
            size,
          );
        } else {
          _reaction = selectedReactionWidget(10, size);
          _post.isReactedd!.reactKeyy!=10;
        }


        //   isSet = true;
        // }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FlutterReactionButtonCheck(
                    onReactionChanged: (reaction, index, isChecked) {
                      setState(() {
                        if (index == -1 && reactIsRemoved == false) {
                          print("react is removed");

                          setState(() {
                            reactIsRemoved = true;
                            if (_post.reactsCountt == null) {
                              _post.reactsCountt = 0;
                            }
                            if (_post.reactsCountt != null && _post.reactsCountt! > 0) {
                              setState(() {
                                reacted = false;
                              });
                              int myIndex=context.read<FeedCubit>().posts.indexWhere((element) => element.id == _post.id);
                              context.read<FeedCubit>().posts[myIndex].reactsCountt= context.read<FeedCubit>().posts[myIndex].reactsCount! - 1;
                              // _post.reactsCountt = _post.reactsCount! - 1;
                            }
                          });
                          _reaction = Reaction(
                            icon: Container(
                              width: size.width * 0.1,
                              height: size.height * 0.03,
                              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                              child: Image.asset("assets/reactions/double_up_arrow_grey.png"),
                            ),
                            previewIcon: Container(
                              width: size.width * 0.12,
                              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                              child: Image.asset("assets/reactions/double_up_arrow_grey.png"),
                            ),
                          );
                          int myIndex=context.read<FeedCubit>().posts.indexWhere((element) => element.id == _post.id);
                          context.read<FeedCubit>().posts[myIndex].isReactedd!.reactKeyy=10;
                          // _post.isReactedd!.reactKey!=10;
                          _onReactButtonPressed(context, 10, _post);


                        } else {
                          setState(() {
                            reactIsRemoved = false;
                          });
                          if (!reactIsRemoved) {
                            if (_post.reactsCount == null) {
                              _post.reactsCountt = 0;
                            }
                            if (!reacted) {
                              int myIndex=context.read<FeedCubit>().posts.indexWhere((element) => element.id == _post.id);
                              context.read<FeedCubit>().posts[myIndex].reactsCountt= context.read<FeedCubit>().posts[myIndex].reactsCount! + 1;

                              // _post.reactsCountt = _post.reactsCount! + 1;


                              setState(() {
                                reacted = true;
                              });
                            }
                          }
                          // context.read<FeedCubit>().posts[widget.index].isReacted!.reactKey=index;
                          _onReactButtonPressed(context, index, _post);
                          setState((){
                            context.read<FeedCubit>().posts[widget.index].isReactedd!.reactKeyy=index;

                            // _post.isReactedd!.reactKeyy=index;
                          });

                          print(_post.isReactedd);
                          _reaction = selectedReactionWidget(index, size);
                          // context.read<FeedCubit>().posts[widget.index].isReacted!.reactKey=index;


                        }
                      });
                    },
                    reactions: <Reaction>[
                      Reaction(
                        icon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset(
                            'assets/reactions/double_arrow_up_icon.gif',
                          ),
                        ),
                        previewIcon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset(
                            'assets/reactions/double_arrow_up_icon.gif',
                          ),
                        ),
                      ),
                      Reaction(
                        icon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                          child: Image.asset(
                            'assets/reactions/double_arrow_down_icon.gif',
                          ),
                        ),
                        previewIcon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset(
                            'assets/reactions/double_arrow_down_icon.gif',
                          ),
                        ),
                      ),
                      Reaction(
                        icon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset('assets/reactions/haha2.png'),
                        ),
                        previewIcon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset('assets/reactions/haha.gif'),
                        ),
                      ),
                      Reaction(
                        icon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset('assets/reactions/wow2.png'),
                        ),
                        previewIcon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset('assets/reactions/wow.gif'),
                        ),
                      ),
                      Reaction(
                        icon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset('assets/reactions/sad.png'),
                        ),
                        previewIcon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                          child: Image.asset('assets/reactions/sad.gif'),
                        ),
                      ),
                      Reaction(
                        icon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                          ),
                          child: Image.asset('assets/reactions/angry.png'),
                        ),
                        previewIcon: Container(
                          width: size.width * 0.12,
                          margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                          child: Image.asset('assets/reactions/angry.gif'),
                        ),
                      ),
                    ],
                    selectedReaction: _reaction,
                    initialReaction: _reaction,
                  ),
                  InkWell(
                    onTap: () {
                      _onLikeCountPressed(context);
                    },
                    child: SizedBox(
                      width: size.width * 0.07,
                      child: Text('${_post.reactsCount ?? '0'}'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: size.width * 0.09),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: state is LoadingState ? null : () => _onSpotButtonPressed(context),
                      icon: SvgPicture.asset(
                        _post.spot?.status == SpotStatus.accept ? 'assets/icons/eye_accepted.svg' : 'assets/icons/eye.svg',
                        color: _post.spot == null ? Colors.grey : null,
                      ),
                    ),
                    if (_post.spotsCount != null)
                      GestureDetector(onTap: () => _openSpottedScreen(context), child: CountTextView(int.parse(_post.spotsCount.toString()))),
                    if (_post.spotsCount == null)
                      GestureDetector(
                        onTap: () => _openSpottedScreen(context),
                        child: const CountTextView(0),
                      ),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: widget.addNavigationToComments ? () => _onCommentsPressed(context) : null,
                icon: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/comment.svg',
                      color: (_post.userCommentCount != null && int.parse(_post.userCommentCount.toString()) > 0) ? null : Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (_post.commentsCount != null)
                      CountTextView(
                        int.parse(_post.commentsCount.toString()),
                      ),
                    if (_post.commentsCount == null)
                      const CountTextView(
                        0,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onCommentsPressed(BuildContext context) {
    Post _post=context.read<FeedCubit>().posts[widget.index];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostViewScreen(
          widget.index,
          post: _post,
        ),
      ),
    );
  }

  void _onReactButtonPressed(BuildContext context, int reactKey, Post post) {
    Post _post=context.read<FeedCubit>().posts[widget.index];

    print("sending react key => $reactKey");
    if (!isLiked && post.isReacted == null) {
      setState(() {
        value = value + 1;
        isLiked = false;
      });
    }

    if (reactKey == -1) {
      context.read<PostCardViewCubit>().likePost(int.parse(_post.id.toString()), 0);
    } else {
      context.read<PostCardViewCubit>().likePost(int.parse(_post.id.toString()), reactKey);
    }
  }

  void _onLikeCountPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostInteractionScreen(widget.index),
      ),
    );
  }

  Future<void> _onSpotButtonPressed(BuildContext context) async {
    Post _post=context.read<FeedCubit>().posts[widget.index];

    if (_post.id != null) {
      if (PreferencesController.isUserSentFirstSpottRequest()) {
        print("kashif ");
        context
            .read<PostCardViewCubit>()
            .requestSpot(int.parse(_post.id.toString()))
            .then((value) => {context.read<FeedCubit>().refreshAllData(context)});
      } else {
        print("kashif sheikh");
        PreferencesController.rememberUserHaveSentFirstSpott();
        showSendSpottRequestDialogBox(context, postId: int.parse(_post.id.toString()));
      }
    }
  }

  void _openSpottedScreen(BuildContext context) {
    Post _post=context.read<FeedCubit>().posts[widget.index];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SpottedRequestsScreen(
          postId: int.parse(_post.id.toString()),
        ),
      ),
    );
  }
}

class _PostHeaderView extends StatelessWidget {
  final int index;
  final Function(bool onTap) onVisibilityChange;
  final Post _post;

  const _PostHeaderView({
    Key? key,
    required this.index,
    required Post post,
    required this.onVisibilityChange,
  })  : _post = post,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListTile(
        onTap: _post.place != null
            ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(index,_post.place!),
                  ),
                );
              }
            : null,
        contentPadding: const EdgeInsets.only(left: 10),
        leading: InkWell(
            onTap: () {
              print(_post.placeId);
              if (_post.place?.placeStoryAvailable == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserViewStoriesScreen(_post.placeId, _post.place!.name!, _post.id),
                    ));
              }
            },
            child: Container(
                decoration: BoxDecoration(
                    border: _post.place?.placeStoryAvailable == true
                        ? _post.seen == false
                            ? Border.all(
                                color: Colors.green,
                                style: BorderStyle.solid,
                                width: 2.0,
                              )
                            : Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2.0,
                              )
                        : null,
                    borderRadius: BorderRadius.circular(8)),
                child: PlaceImageView(_post.place?.images?.firstOrNull))),
        title: Text(_post.place?.name.toString() ?? ''),
        subtitle: Text(
          _post.place?.fullAddress ?? '',
          style: const TextStyle(
            fontSize: 12,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          // color: Colors.red,
          width: size.width * 0.15,
          height: size.height * 0.04,
          alignment: Alignment.centerRight,
          child: (_post.myPost != null && _post.myPost == true)
              ? PopupMenuButton(
                  onSelected: (PopMenuOption value) => _onPopDeleteSelected(context, value),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: PopMenuOption.deletePost,
                        child: Text(
                          'delete Post',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ];
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: SvgPicture.asset(
                      'assets/icons/more.svg',
                      width: size.width * 0.015,
                    ),
                  ),
                )
              : isNotCurrentUser(_post.user?.id)
                  ? PopupMenuButton(
                      onSelected: (PopMenuOption value) => _onPopupMenuSelection(context, value),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            value: PopMenuOption.reportPost,
                            child: Text(LocaleKeys.reportThisPost.tr()),
                          ),
                          PopupMenuItem(
                            value: PopMenuOption.blockUser,
                            child: Text(
                              LocaleKeys.blockUser.tr(),
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ];
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: SvgPicture.asset(
                          'assets/icons/more.svg',
                          width: size.width * 0.015,
                        ),
                      ),
                    )
                  : const SizedBox(),
        ));
  }

  void _onPopupMenuSelection(BuildContext context, PopMenuOption value) {
    switch (value) {
      case PopMenuOption.reportPost:
        context.read<PostCardViewCubit>().reportPost(int.parse(_post.id.toString()));
        break;
      case PopMenuOption.blockUser:
        context.read<PostCardViewCubit>().blockUser(int.parse(_post.id.toString()), _post.user?.id);
        break;
      case PopMenuOption.deletePost:
        // TODO: Handle this case.
        break;
    }
  }

  void _onPopDeleteSelected(BuildContext context, PopMenuOption value) {
    switch (value) {
      case PopMenuOption.deletePost:
        deletePost(context);
        break;
      case PopMenuOption.reportPost:
        // TODO: Handle this case.
        break;
      case PopMenuOption.blockUser:
        // TODO: Handle this case.
        break;
    }
  }

  deletePost(BuildContext context) async {
    context.read<PostCardViewCubit>().deletePost(int.parse(_post.id.toString()), context).then((value) {
      print("Deleted");
      onVisibilityChange(value);
    });
  }
}
