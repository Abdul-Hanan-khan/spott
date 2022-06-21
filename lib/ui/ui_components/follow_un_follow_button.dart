import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spott/blocs/follow_un_follow_cubit/follow_un_follow_cubit.dart';
import 'package:spott/blocs/view_profile_screen_cubits/view_user_profile_cubit/view_user_profile_cubit.dart' hide LoadingState;
import 'package:spott/models/data_models/follow.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:spott/utils/show_snack_bar.dart';

class FollowUnFollowButton extends StatelessWidget {
  final User? _user;
  final Function? updateParent;
  const FollowUnFollowButton(
    this._user, {
    Key? key,
    this.updateParent,
  }) : super(key: key);

  void _onFollowButtonPressed(BuildContext context) {
    if (_user?.isFollower == null ? false : true) {
      context.read<FollowUnFollowCubit>().unFollowUser(_user?.id).then((value) => {
        context
            .read<ViewUserProfileCubit>()
            .viewUserProfile(_user!.id)
      });
    } else {
      context.read<FollowUnFollowCubit>().followUser(_user?.id).then((value) => {
        context
            .read<ViewUserProfileCubit>()
            .viewUserProfile(_user!.id)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('isFollowed => ${_user!.isFollower}');
    return _user != null
        ? BlocConsumer<FollowUnFollowCubit, FollowUnFollowState>(
            listener: (context, state) {
              if (state is ErrorState) {
                showSnackBar(context: context, message: state.message);
              } else if (state is UserFollowedSuccessfully) {
                if (state.apiResponse.follow?.status == FollowStatus.accept) {
                  _user?.userFollowed();
                  updateParent?.call();
                }
              } else if (state is UserUnFollowedSuccessfully) {
                _user?.userUnFollowed();
                updateParent?.call();
              }
            },
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: state is LoadingState
                        ? null
                        : () => _onFollowButtonPressed(context),
                    icon: state is LoadingState
                        ? const LoadingAnimation()
                        : SvgPicture.asset(
                      "assets/icons/follow.svg",
                      color: (_user!.isFollower == null ? false : true)
                          ? null
                          : Colors.grey,
                    ),
                    iconSize: 50,
                    padding: EdgeInsets.zero,
                  )
                ],
              );
            },
          )
        : const SizedBox();
  }
}
