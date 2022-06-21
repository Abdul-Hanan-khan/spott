part of 'feed_cubit.dart';

abstract class FeedCubitState extends Equatable {
  const FeedCubitState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedCubitState {}

class LoadingInitialData extends FeedCubitState {}

class ReloadingData extends FeedCubitState {}

class GPSNoState extends FeedCubitState {}

class NoPostState extends FeedCubitState {}

class ErrorState extends FeedCubitState {
  final String message;

  const ErrorState(this.message);
}

class PostsFetchedSuccessfully extends FeedCubitState {}

class StoriesFetchedSuccessfully extends FeedCubitState {
  final StoryPostApiModel apiResponse;

  const StoriesFetchedSuccessfully(this.apiResponse);
}

class LoadingStories extends FeedCubitState {}

class LoadingPosts extends FeedCubitState {}

class PostCardLoadingStates extends FeedCubitState {
} //!Feed screen will not update for this on the post card will update for this

class PostCardSuccessStates extends FeedCubitState {
  final int postId;

  const PostCardSuccessStates(this.postId);
} //!Feed screen will not update for this on the post card will update for this

class UpdatingPost extends PostCardLoadingStates {}

class PostLiked extends PostCardSuccessStates {
  const PostLiked(int postId) : super(postId);
}

class PostDisliked extends PostCardSuccessStates {
  const PostDisliked(int postId) : super(postId);
}

class UpdatingCommentCount extends PostCardLoadingStates {}

class CommentCountUpdated extends PostCardSuccessStates {
  const CommentCountUpdated(int postId) : super(postId);
}

class RequestingSpot extends PostCardLoadingStates {}

class RequestedForSpot extends PostCardSuccessStates {
  const RequestedForSpot(int postId) : super(postId);
}
