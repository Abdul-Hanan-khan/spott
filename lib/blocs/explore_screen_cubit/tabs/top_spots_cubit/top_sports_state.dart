part of 'top_sports_cubit.dart';

abstract class TopSpotsState extends Equatable {
  const TopSpotsState();

  @override
  List<Object> get props => [];
}

class TopSpotsInitial extends TopSpotsState {}

class TopSpotsFetchingData extends TopSpotsState {}

class TopSpotsRefreshingData extends TopSpotsState {}

class TopSpotsFailedToFetchData extends TopSpotsState {
  final String msg;

  const TopSpotsFailedToFetchData(this.msg);
}

class TopSpotsGPSDisabled extends TopSpotsState {}

class TopSpotsDataFetchedSuccessfully extends TopSpotsState {
  const TopSpotsDataFetchedSuccessfully();
}
