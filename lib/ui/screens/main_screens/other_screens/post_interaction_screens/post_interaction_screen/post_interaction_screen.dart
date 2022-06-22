import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/feed_screen_cubits/feed_cubit/feed_cubit.dart';
import 'package:spott/blocs/feed_screen_cubits/post_interactions_cubit/post_interactions_cubit.dart';
import 'package:spott/blocs/post_reacts_cubit/post_reacts_cubit.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/post_interaction.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/view_profile_screen/view_profile_screen.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/reactions/react_list_view_angry.dart';
import 'package:spott/ui/ui_components/reactions/react_list_view_haha.dart';
import 'package:spott/ui/ui_components/reactions/react_list_view_like.dart';
import 'package:spott/ui/ui_components/reactions/react_list_view_love.dart';
import 'package:spott/ui/ui_components/reactions/react_list_view_sad.dart';
import 'package:spott/ui/ui_components/reactions/react_list_view_wow.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/constants/app_colors.dart';

class PostInteractionScreen extends StatefulWidget {

  final int index;

   PostInteractionScreen(this.index,{Key? key}) : super(key: key);

  @override
  _PostInteractionScreenState createState() => _PostInteractionScreenState();
}

class _InteractionsTabView extends StatelessWidget {
  final List<PostInteraction> _interactions;

  const _InteractionsTabView(this._interactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (_interactions.isEmpty)
        ? _buildNoInteractionView(context)
        : ListView.separated(
            itemCount: _interactions.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () =>
                  _onUserTileTapped(context, _interactions[index].user),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              leading: UserProfileImageView(
                _interactions[index].user,
                radius: 25,
              ),
              title: Text(_interactions[index].user?.username ?? ''),
            ),
            separatorBuilder: (_, __) => const Divider(
              height: 0,
            ),
          );
  }

  Widget _buildNoInteractionView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/no_interaction.svg'),
          const SizedBox(
            height: 30,
          ),
          Text(
            LocaleKeys.beTheFirst.tr(),
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      ),
    );
  }

  void _onUserTileTapped(BuildContext context, User? _user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ViewProfileScreen(_user),
      ),
    );
  }
}

class _PostInteractionScreenState extends State<PostInteractionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) =>
            PostReactsCubit()..getAllReacts(context.read<FeedCubit>().posts[widget.index].id.toString()),
        child: BlocConsumer<PostReactsCubit, PostReactsState>(
          listener: (context, state) {
            if (state is PostReactsSuccessState) {
            } else if (state is PostReactsFailedState) {}
          },
          builder: (context, state) {
            if (state is PostReactsSuccessState) {
              return LoadingScreenView(
                isLoading: state is FetchingPostInteractions,
                child: Scaffold(
                  backgroundColor: AppColors.secondaryBackGroundColor,
                  appBar: AppBar(
                    title: Text(
                      LocaleKeys.interaction.tr(),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: [
                        Container(
                          width: size.width * 0.1,
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Image.asset(
                              'assets/reactions/double_arrow_up_icon.gif'),
                        ),
                        Container(
                          width: size.width * 0.1,
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Image.asset(
                              'assets/reactions/double_arrow_down_icon.gif'),
                        ),
                        Container(
                          width: size.width * 0.1,
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Image.asset('assets/reactions/haha2.png'),
                        ),
                        Container(
                          width: size.width * 0.1,
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Image.asset('assets/reactions/wow2.png'),
                        ),
                        Container(
                          width: size.width * 0.1,
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Image.asset('assets/reactions/sad2.png'),
                        ),
                        Container(
                          width: size.width * 0.1,
                          padding: EdgeInsets.only(bottom: size.height * 0.01),
                          child: Image.asset('assets/reactions/angry2.png'),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      Tab(
                        child: LikeListViewScreen(
                          reacts: state.postReactsModel,
                        ),
                      ),
                      Tab(
                        child: LoveListViewScreen(
                          reacts: state.postReactsModel,
                        ),
                      ),
                      Tab(
                        child: HahaListViewScreen(
                          reacts: state.postReactsModel,
                        ),
                      ),
                      Tab(
                        child: WowListViewScreen(
                          reacts: state.postReactsModel,
                        ),
                      ),
                      Tab(
                        child: SadListViewScreen(
                          reacts: state.postReactsModel,
                        ),
                      ),
                      Tab(
                        child: AngryListViewScreen(
                          reacts: state.postReactsModel,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state is PostReactsFailedState) {
              return Scaffold(
                body: Center(
                  child: Text("${state.postReactsModel.status}"),
                ),
              );
            }
            if (state is PostReactsLoadingState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text("Network error"),
                ),
              );
            }
          },
        ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }
}
