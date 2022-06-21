part of 'post_interactions_cubit.dart';

abstract class PostInteractionsCubitState extends Equatable {
  const PostInteractionsCubitState();

  @override
  List<Object> get props => [];
}

class PostLikesInitial extends PostInteractionsCubitState {}

class FetchingPostInteractions extends PostInteractionsCubitState {}

class PostInteractionsFetched extends PostInteractionsCubitState {
  final GetPostInteractionApiResponse apiResponse;

  const PostInteractionsFetched(this.apiResponse);
}

class PostDisLikesFetched extends PostInteractionsCubitState {
  final List<PostInteraction> dislikes;

  const PostDisLikesFetched(this.dislikes);
}

class ErrorState extends PostInteractionsCubitState {
  final String message;

  const ErrorState(this.message);
}
