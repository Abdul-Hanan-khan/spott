import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/view_profile_screen_cubits/user_followers_screen_cubit/user_followers_screen_cubit.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../view_profile_screen.dart';

class UserFollowersScreen extends StatelessWidget {
  final User? _user;
  const UserFollowersScreen(this._user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserFollowersScreenCubit()..getFollowers(_user?.id),
      child:
          BlocConsumer<UserFollowersScreenCubit, UserFollowersScreenCubitState>(
        listener: (context, state) {
          if (state is FailedToFetchFollowers) {
            if (state.message != null) {
              showSnackBar(context: context, message: state.message!);
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is FetchingFollowers,
            child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.follower.tr(),style: const TextStyle(
                  color: Colors.black,
                ),),
              ),
              body: state is! FollowerFetchedSuccessfully
                  ? const SizedBox()
                  : ListView.separated(
                      itemCount: state.followers.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: UserProfileImageView(
                            state.followers[index].follower),
                        title:
                            Text(state.followers[index].follower?.name ?? ''),
                        subtitle: Text(
                            state.followers[index].follower?.username ?? ''),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewProfileScreen(
                                  state.followers[index].follower)));
                        },
                      ),
                      separatorBuilder: (_, __) => const Divider(),
                    ),
            ),
          );
        },
      ),
    );
  }
}
