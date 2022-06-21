import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/feed_screen/stories_screens/view_stories_screen.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../screens/main_screens/feed_screen/stories_screens/create_stories_screen/camera_screen.dart';

class GroupStoriesListView extends StatelessWidget {
  final bool isFeedScreen;
  final bool showAddStoryButton;
  final List<GroupStories> _stories;

  const GroupStoriesListView(this._stories,
      {Key? key, this.showAddStoryButton = false, this.isFeedScreen = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(20),
        itemCount: showAddStoryButton ? (_stories.length > 0 ? 2 : 1) : 1,
        itemBuilder: (context, index) {
          if (index == 0 && showAddStoryButton) {
            return _buildAddYourStoryButton(context);
          } else {
            // return _StoryCardView(
            //   story: _stories
            //       .elementAt(showAddStoryButton ? (index - 1) : index),
            //   onStoryTap: (Post story) => _onStoryTab(context, story),
            // );

            return _StoryCardView(
                story: _stories.elementAt(0),
                onStoryTap: (GroupStories story) =>
                    _onStoryTab(context, story));
          }
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
      ),
    );
  }

  Widget _buildAddYourStoryButton(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () => _openStoriesScreen(context),
      child: SizedBox(
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CircleAvatar(),
                ),
                SvgPicture.asset(
                  'assets/icons/plus.svg',
                  height: 20,
                )
              ],
            ),
            Text(
              LocaleKeys.addYourMoments.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }

  void _onStoryTab(BuildContext context, GroupStories story) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         ViewStoriesScreen(allStories: _stories, story: story),
    //   ),
    // );
  }

  Future<void> _openStoriesScreen(BuildContext context) async {
    if (AppData.cameras == null || AppData.cameras!.isEmpty) {
      showSnackBar(
          context: context, message: LocaleKeys.cameraNotFoundError.tr());
    } else {
      if (await Permission.camera.isGranted &&
          await Permission.microphone.isGranted) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CameraScreen()));
      } else {
        [Permission.camera, Permission.microphone].request().then((statues) {
          if ((statues[Permission.camera]?.isGranted == true) &&
              (statues[Permission.microphone]?.isGranted == true)) {
            _openStoriesScreen(context);
          } else {
            showSnackBar(
                context: context,
                message: LocaleKeys.cameraPermissionError.tr());
          }
        });
      }
    }
  }
}

class _StoryCardView extends StatelessWidget {
  final GroupStories story;
  final Function(GroupStories _story) onStoryTap;
  const _StoryCardView({
    required this.story,
    required this.onStoryTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              onStoryTap.call(story);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 3),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.secondary,
                  image:
                      story.type == PostType.image && story.media?.first != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                  story.media?.first ?? ''),
                            )
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UserProfileImageView(
                      story.user,
                      radius: 15,
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      story.user?.username ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 100,
          child: Center(
              // child: Text(
              //   story.place?.name ?? '',
              //   style: Theme.of(context).textTheme.bodyText1,
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              // ),
              ),
        )
      ],
    );
  }
}
