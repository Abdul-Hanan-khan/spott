part of 'post_view_cubit.dart';

abstract class PostViewState extends Equatable {
  const PostViewState();

  @override
  List<Object> get props => [];
}

class PostViewInitial extends PostViewState {}

class PostViewLoadingState extends PostViewState {}

class PostViewSuccessState extends PostViewState {
  final ViewPostApiModel viewPostApiModel;

  const PostViewSuccessState(this.viewPostApiModel);
}

class PostViewFailedState extends PostViewState {
  final ViewPostApiModel viewPostApiModel;

  const PostViewFailedState(this.viewPostApiModel);
}

class PostCommentsFetched extends PostViewState {
  const PostCommentsFetched();
}
class ErrorState extends PostViewState {
  final String message;

  const ErrorState(
      int postId,
      this.message,
      );
}
class SpottRequestStatusUpdated extends PostViewState {
  final Spot? spot;

  const SpottRequestStatusUpdated(this.spot);
}