part of 'user_following_screen_cubit.dart';

abstract class UserFollowingScreenCubitState extends Equatable {
  const UserFollowingScreenCubitState();

  @override
  List<Object> get props => [];
}

class UserFollowingScreenCubitInitial extends UserFollowingScreenCubitState {}

class FetchingFollowing extends UserFollowingScreenCubitState {}

class FailedToFetchFollowing extends UserFollowingScreenCubitState {
  final String? message;

  const FailedToFetchFollowing(this.message);
}

class FollowingFetchedSuccessfully extends UserFollowingScreenCubitState {
  final List<Follow> following;

  const FollowingFetchedSuccessfully(this.following);
}
