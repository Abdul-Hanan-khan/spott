part of 'view_stories_cubit.dart';

abstract class ViewStoriesCubitState extends Equatable {
  const ViewStoriesCubitState();

  @override
  List<Object> get props => [];
}

class ViewStoriesCubitInitial extends ViewStoriesCubitState {}

class UpdatingStory extends ViewStoriesCubitState {}

class FailedState extends ViewStoriesCubitState {
  final String? message;

  const FailedState(this.message);
}

class StoryMarkedAsSeen extends ViewStoriesCubitState {}

class UserBlocked extends ViewStoriesCubitState {
  final BlockUserApiResponse apiResponse;

  const UserBlocked(this.apiResponse);
}

class StoryReported extends ViewStoriesCubitState {
  final ReportContentApiResponse apiResponse;

  const StoryReported(this.apiResponse);
}

class SpottRequestStatusUpdated extends ViewStoriesCubitState {
  final Spot? spot;

  const SpottRequestStatusUpdated(this.spot);
}
