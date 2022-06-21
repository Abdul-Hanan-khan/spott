part of 'comments_cubit.dart';

abstract class CommentsCubitState extends Equatable {
  const CommentsCubitState();

  @override
  List<Object> get props => [];
}

class CommentsInitial extends CommentsCubitState {}

class RefreshComment extends CommentsCubitState {}

class FetchingComments extends CommentsCubitState {}

class RefreshingComments extends CommentsCubitState {}

class CommentsFetched extends CommentsCubitState {
  final List<Comment> comments;

  const CommentsFetched(this.comments);
}

class FailedState extends CommentsCubitState {
  final String message;

  const FailedState(this.message);
}

class AddingNewComment extends CommentsCubitState {}

class CommentAddedSuccessfully extends CommentsCubitState {
  final int postId;
  final Comment comment;

  const CommentAddedSuccessfully(this.postId, this.comment);
}
