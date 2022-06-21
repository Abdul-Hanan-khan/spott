part of 'activity_screen_cubit.dart';

abstract class ActivityScreenState extends Equatable {
  const ActivityScreenState();

  @override
  List<Object> get props => [];
}

class ActivityScreenInitial extends ActivityScreenState {}

class FetchingNotifications extends ActivityScreenState {}

class RefreshingNotifications extends ActivityScreenState {}

class UpdatingNotifications extends ActivityScreenState {}

class NotificationsErrorState extends ActivityScreenState {
  final String message;

  const NotificationsErrorState(this.message);
}

class NotificationsFetchedSuccessFully extends ActivityScreenState {
  final List<notifications.Notifications> nearbyNotifications;
  final List<notifications.Notifications> youNotifications;

  const NotificationsFetchedSuccessFully(
      {required this.nearbyNotifications, required this.youNotifications});
}

class NotificationsMarkedRead extends ActivityScreenState {}

class UpdatingSpotRequestStatus extends ActivityScreenState {}

class SpotRequestUpdated extends ActivityScreenState {}

class UpdatingFollowRequest extends ActivityScreenState {
  final FollowRequestUpdateStatus status;

  const UpdatingFollowRequest(this.status);
}

class FollowRequestUpdated extends ActivityScreenState {}
