part of 'post_card_view_cubit.dart';

abstract class PostCardViewState extends Equatable {
  final int postId;

  const PostCardViewState(this.postId);

  @override
  List<Object> get props => [];
}

class PostCardViewInitial extends PostCardViewState {
  const PostCardViewInitial(int postId) : super(postId);
}

class LoadingState extends PostCardViewState{
  LoadingState(int postId) : super(postId);
}

class UpdatingPost extends PostCardViewState {
  const UpdatingPost(int postId) : super(postId);
}

class ErrorState extends PostCardViewState {
  final String message;

  const ErrorState(
    int postId,
    this.message,
  ) : super(postId);
}

class PostLiked extends PostCardViewState {
  const PostLiked(int postId) : super(postId);
}

class PostDisliked extends PostCardViewState {
  const PostDisliked(int postId) : super(postId);
}

class SpottRequestStatusUpdated extends PostCardViewState {
  final Spot? spot;

  const SpottRequestStatusUpdated(int postId,this.spot) : super(postId);
}

class CommentCountUpdated extends PostCardViewState {
  const CommentCountUpdated(int postId) : super(postId);
}

class UserBlocked extends PostCardViewState {
  final BlockUserApiResponse apiResponse;

  const UserBlocked(int postId, this.apiResponse) : super(postId);
}

class PostReported extends PostCardViewState {
  final ReportContentApiResponse apiResponse;

  const PostReported(int postId, this.apiResponse) : super(postId);
}
