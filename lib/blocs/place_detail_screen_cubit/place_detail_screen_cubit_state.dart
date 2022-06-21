part of 'place_detail_screen_cubit.dart';

abstract class PlaceDetailScreenCubitState extends Equatable {
  const PlaceDetailScreenCubitState();

  @override
  List<Object> get props => [];
}

class PlaceDetailScreenCubitInitial extends PlaceDetailScreenCubitState {}

class LoadingState extends PlaceDetailScreenCubitState {}

class FailedToFetchDetail extends PlaceDetailScreenCubitState {
  final String message;

  const FailedToFetchDetail(this.message);
}

class PlaceDetailFetched extends PlaceDetailScreenCubitState {
  final Place place;

  const PlaceDetailFetched(this.place);
}

class FailedToGetShareAbleLink extends PlaceDetailScreenCubitState {
  final String? message;

  const FailedToGetShareAbleLink(this.message);
}

class ShareAbleLinkFetched extends PlaceDetailScreenCubitState {
  final String link;

  const ShareAbleLinkFetched(this.link);
}

class PlaceFollowLoadingState extends PlaceDetailScreenCubitState {}

class PlaceFollowState extends PlaceDetailScreenCubitState {
  final PlaceFollowApiModel placeFollowApiModel;

  const PlaceFollowState(this.placeFollowApiModel);
}

class PlaceFollowErrorState extends PlaceDetailScreenCubitState {
  final PlaceFollowApiModel placeFollowApiModel;

  const PlaceFollowErrorState(this.placeFollowApiModel);
}

class PlaceUnFollowState extends PlaceDetailScreenCubitState {
  final PlaceUnFollowApiModel placeUnFollowState;

  const PlaceUnFollowState(this.placeUnFollowState);
}

class PlaceUnFollowErrorState extends PlaceDetailScreenCubitState {
  final PlaceUnFollowApiModel placeUnFollowState;

  const PlaceUnFollowErrorState(this.placeUnFollowState);
}
