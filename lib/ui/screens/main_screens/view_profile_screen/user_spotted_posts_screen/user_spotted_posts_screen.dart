import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spott/blocs/view_profile_screen_cubits/user_spotted_posts_screen_cubit/user_spotted_posts_screen_cubit.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/ui_components/loading_screen_view.dart';
import 'package:spott/ui/ui_components/post_card_view.dart';
import 'package:spott/utils/show_snack_bar.dart';

class UserSpottedPostsScreen extends StatelessWidget {
  final User? _user;
  const UserSpottedPostsScreen(
    this._user, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSpottedPostsScreenCubit()..fetchPosts(_user?.id),
      child: BlocConsumer<UserSpottedPostsScreenCubit,
          UserSpottedPostsScreenCubitState>(
        listener: (context, state) {
          if (state is FailedToFetchPosts) {
            if (state.message != null) {
              showSnackBar(context: context, message: state.message!);
            }
          }
        },
        builder: (context, state) {
          return LoadingScreenView(
            isLoading: state is FetchingPosts,
            child: Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.spotted.tr(),style: const TextStyle(
                  color: Colors.black,
                )),
              ),
              body: state is! PostsFetchedSuccessfully
                  ? const SizedBox()
                  : ListView.separated(
                      itemCount: state.posts?.length ?? 0,
                      itemBuilder: (context, index) {
                        return PostCardView(index);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
