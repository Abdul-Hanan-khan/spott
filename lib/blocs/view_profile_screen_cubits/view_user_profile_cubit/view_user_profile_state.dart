part of 'view_user_profile_cubit.dart';

abstract class ViewUserProfileState extends Equatable {
  const ViewUserProfileState();

  @override
  List<Object> get props => [];
}

class ViewUserProfileInitial extends ViewUserProfileState {}

class LoadingState extends ViewUserProfileState {}

class FailedToFetchProfileState extends ViewUserProfileState {
  final String? message;

  const FailedToFetchProfileState(this.message);
}

class FailedState extends ViewUserProfileState {
  final String? message;

  const FailedState(this.message);
}

class FetchedViewUserProfile extends ViewUserProfileState {
  final ViewProfileApiResponse? apiResponse;

  const FetchedViewUserProfile(this.apiResponse);
}

class BlockingUser extends ViewUserProfileState {}

class UserBlocked extends ViewUserProfileState {
  final BlockUserApiResponse apiResponse;

  const UserBlocked(this.apiResponse);
}

class UserShareLinkFetched extends ViewUserProfileState {
  final String link;

  const UserShareLinkFetched(this.link);
}
