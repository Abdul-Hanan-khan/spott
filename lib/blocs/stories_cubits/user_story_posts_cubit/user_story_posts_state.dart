part of 'user_story_posts_cubit.dart';

abstract class UserStoryPostsState extends Equatable {
  const UserStoryPostsState();

  @override
  List<Object> get props => [];
}

class UserStoryPostsInitial extends UserStoryPostsState {

}
class LoadingData extends UserStoryPostsState {}

class FetchedUserPostsSuccessfully extends UserStoryPostsState {
  final List<Posts>? posts;

  FetchedUserPostsSuccessfully(this.posts);
}

class ErrorState extends UserStoryPostsState {
  final String message;

  ErrorState(this.message);
}