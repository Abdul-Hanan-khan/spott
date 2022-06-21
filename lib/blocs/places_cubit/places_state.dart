part of 'places_cubit.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();

  @override
  List<Object> get props => [];
}

class PlacesInitial extends PlacesState {}

class ErrorState extends PlacesState {
  final String message;

  const ErrorState(this.message);
}

class FetchingPlaceSuggestions extends PlacesState {}

class PlaceSuggestionsFetchedSuccessfully extends PlacesState {
  final GetPlaceSuggestionsApiResponse apiResponse;

  const PlaceSuggestionsFetchedSuccessfully(this.apiResponse);
}

class FetchingPlaceCategories extends PlacesState {}

class PlaceCategoriesFetchedSuccessfully extends PlacesState {
  final List<PlaceCategory> categories;

  const PlaceCategoriesFetchedSuccessfully(this.categories);
}

class AddingNewPlace extends PlacesState {}

class PlaceAddedSuccessfully extends PlacesState {
  final Place place;

  const PlaceAddedSuccessfully(this.place);
}
