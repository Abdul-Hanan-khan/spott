part of 'follow_un_follow_cubit.dart';

abstract class FollowUnFollowState extends Equatable {
  const FollowUnFollowState();

  @override
  List<Object> get props => [];
}

class FollowUnFollowInitial extends FollowUnFollowState {}

class LoadingState extends FollowUnFollowState {}

class ErrorState extends FollowUnFollowState {
  final String message;

  const ErrorState(this.message);
}

class UserFollowedSuccessfully extends FollowUnFollowState {
  final FollowUserApiResponse apiResponse;

  const UserFollowedSuccessfully(this.apiResponse);
}

class UserUnFollowedSuccessfully extends FollowUnFollowState {
  final FollowUserApiResponse apiResponse;

  const UserUnFollowedSuccessfully(this.apiResponse);
}
