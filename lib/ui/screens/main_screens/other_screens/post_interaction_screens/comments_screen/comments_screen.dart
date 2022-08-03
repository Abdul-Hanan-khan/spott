import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spott/blocs/feed_screen_cubits/comments_cubit/comments_cubit.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/blocs/post_card_view_cubit/post_card_view_cubit.dart';
import 'package:spott/models/data_models/comment.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/app_text_field.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/ui/ui_components/post_card_view_detail.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/enums.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

class CommentsScreen extends StatefulWidget {
  final int index;

  CommentsScreen(this.index, {Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController _commentTextEditingController =
      TextEditingController();

  Completer<void>? _refreshCompleter;

  final List<Comment> _comments = [];

  @override
  Widget build(BuildContext context) {
    print(
        'post id => ${context.read<FeedCubit>().posts[widget.index].id.toString()}');
    return BlocProvider<CommentsCubit>(
      create: (context) => CommentsCubit()
        ..getAllComments(int.parse(
            context.read<FeedCubit>().posts[widget.index].id.toString())),
      child: BlocConsumer<CommentsCubit, CommentsCubitState>(
        listener: (context, state) {
          if (state is FailedState) {
            _stopPullToRefreshLoader();
            showSnackBar(context: context, message: state.message);
          } else if (state is CommentsFetched) {
            _comments.clear();
            _comments.addAll(state.comments);
            _stopPullToRefreshLoader();
          } else if (state is CommentAddedSuccessfully) {
            if (state.postId ==
                context.read<FeedCubit>().posts[widget.index].id) {
              _comments.insert(0, state.comment);
              context.read<PostCardViewCubit>().commentAdd(int.parse(
                  context.read<FeedCubit>().posts[widget.index].id.toString()));
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is FetchingComments,
            child: Scaffold(
              backgroundColor: AppColors.secondaryBackGroundColor,
              appBar: AppBar(
                title: Text(
                  LocaleKeys.details.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => _onRefresh(context),
                      child: ListView(
                        padding: const EdgeInsets.only(top: 20, bottom: 100),
                        children: [
                          PostCardView(widget.index,
                              addNavigationToComments: false),
                          // PostCardView(
                          //   widget.index,
                          //   addNavigationToComments: false,
                          // ),
                          if (_comments.isEmpty) _buildNoCommentsView(context),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _comments.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 20,
                            ),
                            itemBuilder: (context, index) =>
                                _CommentView(_comments[index], index),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            controller: _commentTextEditingController,
                            hintText: LocaleKeys.typeACommentHere.tr(),
                          ),
                        ),
                        IconButton(
                          onPressed: state is AddingNewComment
                              ? null
                              : () => _onAddNewCommentPressed(context),
                          icon: state is AddingNewComment
                              ? const LoadingAnimation()
                              : const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoCommentsView(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        SvgPicture.asset('assets/icons/no_comments.svg'),
        Text(
          LocaleKeys.noComment.tr(),
          style: Theme.of(context).textTheme.headline5,
        ),
        Text(
          LocaleKeys.beTheFirst.tr(),
          // LocaleKeys.leaveAComment.tr(),
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }

  void _onAddNewCommentPressed(BuildContext context) {
    if (_commentTextEditingController.text.isNotEmpty) {
      context.read<CommentsCubit>().addNewComment(
          int.parse(
              context.read<FeedCubit>().posts[widget.index].id.toString()),
          _commentTextEditingController.text);
      _commentTextEditingController.clear();
    }
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<CommentsCubit>().getAllComments(
        int.parse(context.read<FeedCubit>().posts[widget.index].id.toString()),
        isRefreshing: true);
    return _refreshCompleter?.future;
  }

  void _stopPullToRefreshLoader() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }
}

class _CommentView extends StatefulWidget {
  final Comment _comment;

  final int index;

  const _CommentView(this._comment, this.index, {Key? key}) : super(key: key);

  @override
  State<_CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<_CommentView> {
  void _onDeleteCommentPressed(
      {required BuildContext context, required int commentId}) async {
    context
        .read<CommentsCubit>()
        .deleteComment(commentId: commentId, isRefreshing: true)
        .then((value) => {
              context.read<CommentsCubit>().getAllComments(
                  int.parse(context
                      .read<FeedCubit>()
                      .posts[widget.index]
                      .id
                      .toString()),
                  isRefreshing: true)
            });
  }

  @override
  Widget build(BuildContext context) {
    var timeStamp = getStringFromTime(widget._comment.createdAt);

        Size size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ViewProfileScreen(widget._comment.user)));
            },
            child: UserProfileImageView(widget._comment.user)),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget._comment.user?.username ?? '',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    (widget._comment.userId == AppData.currentUser!.id)
                        ? PopupMenuButton(
                            onSelected: (PopMenuDeleteComment value) {
                              print("...................${widget._comment.id}");
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: PopMenuDeleteComment.deleteComment,
                                  child: GestureDetector(
                                    onTap: () {
                                      _onDeleteCommentPressed(
                                          commentId: widget._comment.id!,
                                          context: context);
                                    },
                                    child: Text(
                                      'delete comment',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ];
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: SvgPicture.asset(
                                'assets/icons/more.svg',
                                width: size.width * 0.01,
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget._comment.comment ?? ''),
                if (widget._comment.createdAt != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(timeStamp['postTime'].toString()+timeStamp['postSymbol'].toString().tr(),
                      style: TextStyle(
                          fontSize: 12, color: Theme.of(context).hintColor),
                    ),
                  )
              ],
            ),
          ),
        )
      ],
    );
  }
}
