import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/place_detail_screen_cubit/place_detail_screen_cubit.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/other_screens/place_detail_screen/place_followers_screen.dart';
import 'package:spott/ui/ui_components/count_text_view.dart';
import 'package:spott/ui/ui_components/group_stories_list_view.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/place_image_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/ui/ui_components/stories_list_view.dart';
import 'package:spott/utils/constants/app_colors.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../../../../ui_components/place_details_card_view.dart';
import 'components/all_rating_screen.dart';
import 'components/dialog_box.dart';
import 'components/spotted_list_view_screen.dart';

class PlaceDetailScreen extends StatefulWidget {
  final Place _place;


  const PlaceDetailScreen(

    this._place, {
    Key? key,
  }) : super(key: key);

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Place? _place;

  void _openFollowersScreen() {
    if (_place?.followers != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlaceFollowersScreen(_place!.followers!),
        ),
      );
    }
  }

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

  bool isFollowApiCalled = false;
  bool isFollowed = true;
  var userId;

  @override
  Widget build(BuildContext context) {
    print("Place id => ${widget._place.id}");
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => PlaceDetailScreenCubit()..fetchPlaceDetail(widget._place.id.toString()),
      child: BlocConsumer<PlaceDetailScreenCubit, PlaceDetailScreenCubitState>(
        listener: (context, state) {
          if (state is FailedToFetchDetail) {
            // showSnackBar(context: context, message: state.message);
          } else if (state is PlaceDetailFetched) {
            _place = state.place;
          } else if (state is FailedToGetShareAbleLink) {
            if (state.message != null) {
              showSnackBar(context: context, message: state.message!);
            }
          } else if (state is ShareAbleLinkFetched) {
            sharePlaceLink(state.link);
          } else if (state is PlaceFollowLoadingState) {
            isFollowApiCalled = true;
          } else if (state is PlaceFollowState) {
            isFollowApiCalled = false;
            isFollowed = true;
            showSnackBar(
              context: context,
              message: state.placeFollowApiModel.message.toString(),
            );
          } else if (state is PlaceFollowErrorState) {
            showSnackBar(
              context: context,
              message: state.placeFollowApiModel.message.toString(),
            );
          } else if (state is PlaceUnFollowState) {
            isFollowApiCalled = false;
            isFollowed = false;
            showSnackBar(
              context: context,
              message: state.placeUnFollowState.message.toString(),
            );
          } else if (state is PlaceUnFollowErrorState) {
            isFollowApiCalled = false;
            isFollowed = false;
            showSnackBar(
              context: context,
              message: state.placeUnFollowState.message.toString(),
            );
          }
        },
        builder: (context, state) {
          for (int i = 0; i < _place!.followers!.length; i++) userId = _place!.followers![i].userId;

          return Scaffold(
            body: NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 250,
                    stretch: true,
                    pinned: true,
                    centerTitle: false,
                    title: visibilityOfTitle
                        ? Text(
                            '${widget._place.name}',
                            style: TextStyle(fontSize: size.width * 0.043, color: Colors.black, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          )
                        : const SizedBox(),
                    actions: [
                      IconButton(
                        onPressed: () => _onShareButtonPressed(context),
                        icon: const Icon(Icons.share),
                      ),
                      IconButton(
                        onPressed: () => showDialogBox(
                          context,
                          _place!.id.toString(),
                        ),
                        icon: const Icon(Icons.star_rate),
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
                        _buildProfileListTile(context, state),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildStoriesListView()
                      ],
                    ),
                  ),
                ];
              },
              body: Container(
                color: AppColors.secondaryBackGroundColor,
                child: _buildUserPostsListView(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setupScrollController(context);
    if (widget._place.isFollow == null) {
      isFollowed = false;
    } else {
      isFollowed = true;
    }
    _place = widget._place;
    print(widget._place.id);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _buildCoverImageView() => (_place?.images != null && _place!.images!.isNotEmpty)
      ? CachedNetworkImage(
          imageUrl: _place!.images!.length > 1 ? _place!.images!.elementAt(1) : _place!.images!.elementAt(0),
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

  Widget _buildProfileListTile(BuildContext context, PlaceDetailScreenCubitState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            _place?.name ?? '',
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            _place?.fullAddress ?? '',
            style: Theme.of(context).textTheme.subtitle1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: PlaceImageView(_place?.images?.first),
          trailing: IconButton(
            onPressed: state is LoadingState
                ? null
                : () {
                    if (_place!.isFollow != null) {
                      context
                          .read<PlaceDetailScreenCubit>()
                          .unfollow(_place!.id.toString())
                          .then((value) => {context.read<PlaceDetailScreenCubit>().fetchPlaceDetail(_place!.id.toString())});
                    } else {
                      context
                          .read<PlaceDetailScreenCubit>()
                          .followScreen(_place!.id.toString())
                          .then((value) => {context.read<PlaceDetailScreenCubit>().fetchPlaceDetail(_place!.id.toString())});
                    }
                  },
            icon: state is LoadingState
                ? const LoadingAnimation()
                : SvgPicture.asset(
                    "assets/icons/follow.svg",
                    color: _place!.isFollow != null ? null : Colors.grey,
                  ),
            iconSize: 50,
            padding: EdgeInsets.zero,
          ),
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
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CountTextView(
                    _place?.followCount,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpottedListViewScreen(
                      placeId: _place?.id.toString(),
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    LocaleKeys.spotted.tr(),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.purple,
                        ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  CountTextView(_place?.spotCount, style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllRatingScreen(
                      placeId: _place?.id.toString(),
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    LocaleKeys.rating.tr(),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    _place?.averageRating?.toString() ?? '',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildStoriesListView() {
    print('Length of group stories => ${_place!.groupStories?.length}');
    return (_place?.groupStories != null && _place!.groupStories!.isNotEmpty && _place!.isFollow != null)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text(
                  LocaleKeys.moments.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              StoriesListView(
                _place!.groupStories!,
                showAddStoryButton: false,
              ),
            ],
          )
        : Container();
  }

  Widget _buildUserPostsListView() {
    return (_place?.posts != null)
        ? ListView.separated(
            padding: const EdgeInsets.only(top: 10),
            itemCount: _place!.posts!.length,
            itemBuilder: (context, index) =>
                PlaceDetailsPostCardView(index,post: _place!.posts![index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          )
        : const SizedBox();
  }

  void _onShareButtonPressed(BuildContext context) {
    context.read<PlaceDetailScreenCubit>().getShareAbleLink(widget._place.id.toString());
  }

  showDialogBox(BuildContext context, String? placeId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CustomDialogBox(
            placeId: placeId,
          ),
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
