part of 'view_blocked_users_screen_cubit.dart';

abstract class ViewBlockedUsersScreenCubitState extends Equatable {
  const ViewBlockedUsersScreenCubitState();

  @override
  List<Object> get props => [];
}

class ViewBlockedUsersScreenCubitInitial
    extends ViewBlockedUsersScreenCubitState {}

class LoadingState extends ViewBlockedUsersScreenCubitState {}

class ErrorState extends ViewBlockedUsersScreenCubitState {
  final String message;

  const ErrorState(this.message);
}

class UsersFetched extends ViewBlockedUsersScreenCubitState {
  final List<User> users;

  const UsersFetched(this.users);
}

class UserUnblocked extends ViewBlockedUsersScreenCubitState {
  final int userId;
  final String? message;

  const UserUnblocked(this.userId, this.message);
}
