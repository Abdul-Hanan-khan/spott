part of 'user_spotted_posts_screen_cubit.dart';

abstract class UserSpottedPostsScreenCubitState extends Equatable {
  const UserSpottedPostsScreenCubitState();

  @override
  List<Object> get props => [];
}

class UserSpottedPostsScreenCubitInitial
    extends UserSpottedPostsScreenCubitState {}

class FetchingPosts extends UserSpottedPostsScreenCubitState {}

class FailedToFetchPosts extends UserSpottedPostsScreenCubitState {
  final String? message;

  const FailedToFetchPosts(this.message);
}

class PostsFetchedSuccessfully extends UserSpottedPostsScreenCubitState {
  final List<Post>? posts;

  const PostsFetchedSuccessfully(this.posts);
}
