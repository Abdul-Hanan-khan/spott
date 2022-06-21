part of 'explore_screen_cubit.dart';

abstract class ExploreScreenState extends Equatable {
  const ExploreScreenState();

  @override
  List<Object> get props => [];
}

class ExploreScreenInitial extends ExploreScreenState {}

class FetchingData extends ExploreScreenState {}

class RefreshingData extends ExploreScreenState {}

class FailedToFetchData extends ExploreScreenState {
  final String message;

  const FailedToFetchData(this.message);
}

class DataFetchedSuccessfully extends ExploreScreenState {
  final GetExploreApiResponse apiResponse;

  const DataFetchedSuccessfully(this.apiResponse);
}

class GPSDisabled extends ExploreScreenState {}
