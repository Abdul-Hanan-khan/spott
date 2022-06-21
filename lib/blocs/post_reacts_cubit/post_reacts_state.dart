part of 'post_reacts_cubit.dart';

abstract class PostReactsState extends Equatable {
  const PostReactsState();

  @override
  List<Object> get props => [];
}

class PostReactsInitial extends PostReactsState {}

class PostReactsLoadingState extends PostReactsState {}

class PostReactsSuccessState extends PostReactsState {
  final PostReactsModel postReactsModel;

  const PostReactsSuccessState(this.postReactsModel);
}

class PostReactsFailedState extends PostReactsState {
  final PostReactsModel postReactsModel;

  const PostReactsFailedState(this.postReactsModel);
}
