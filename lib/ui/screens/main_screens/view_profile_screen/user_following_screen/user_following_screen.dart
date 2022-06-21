import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/view_profile_screen_cubits/user_following_screen_cubit/user_following_screen_cubit.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/user_profile_image_view.dart';
import 'package:spott/utils/show_snack_bar.dart';

import '../view_profile_screen.dart';

class UserFollowingScreen extends StatelessWidget {
  final User? _user;
  const UserFollowingScreen(this._user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserFollowingScreenCubit()..getFollowing(_user?.id),
      child:
          BlocConsumer<UserFollowingScreenCubit, UserFollowingScreenCubitState>(
        listener: (context, state) {
          if (state is FailedToFetchFollowing) {
            if (state.message != null) {
              showSnackBar(context: context, message: state.message!);
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is FetchingFollowing,
            child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.following.tr(),style: const TextStyle(
                  color: Colors.black,
                )),
              ),
              body: state is! FollowingFetchedSuccessfully
                  ? const SizedBox()
                  : ListView.separated(
                      itemCount: state.following.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: UserProfileImageView(
                            state.following[index].following),
                        title:
                            Text(state.following[index].following?.name ?? ''),
                        subtitle: Text(
                            state.following[index].following?.username ?? ''),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewProfileScreen(
                                  state.following[index].following)));
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
