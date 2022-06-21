part of 'top_places_cubit.dart';

abstract class TopPlacesState extends Equatable {
  const TopPlacesState();

  @override
  List<Object> get props => [];
}

class TopPlacesInitial extends TopPlacesState {}

class TopPlacesFetchingData extends TopPlacesState {}

class TopPlacesRefreshingData extends TopPlacesState {}

class TopPlacesFailedToFetchData extends TopPlacesState {
  final String msg;

  const TopPlacesFailedToFetchData(this.msg);
}

class TopPlacesGPSDisabled extends TopPlacesState {}

class TopPlacesDataFetchedSuccessfully extends TopPlacesState {}
