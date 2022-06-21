part of 'user_followers_screen_cubit.dart';

abstract class UserFollowersScreenCubitState extends Equatable {
  const UserFollowersScreenCubitState();

  @override
  List<Object> get props => [];
}

class UserFollowersScreenCubitInitial extends UserFollowersScreenCubitState {}

class FetchingFollowers extends UserFollowersScreenCubitState {}

class FailedToFetchFollowers extends UserFollowersScreenCubitState {
  final String? message;

  const FailedToFetchFollowers(this.message);
}

class FollowerFetchedSuccessfully extends UserFollowersScreenCubitState {
  final List<Follow> followers;

  const FollowerFetchedSuccessfully(this.followers);
}
