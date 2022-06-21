part of 'place_stories_cubit.dart';

abstract class PlaceStoriesState extends Equatable {
  const PlaceStoriesState();
  @override
  List<Object> get props => [];
}

class PlaceStoriesInitial extends PlaceStoriesState {

}
class LoadingData extends PlaceStoriesState {}

class FetchedUserPostsSuccessfully extends PlaceStoriesState {
  final List<Stories>? stories;

  FetchedUserPostsSuccessfully(this.stories);
}

class ErrorState extends PlaceStoriesState {
  final String message;

  ErrorState(this.message);
}