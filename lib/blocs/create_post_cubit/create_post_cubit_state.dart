part of 'create_post_cubit.dart';

abstract class CreatePostCubitState extends Equatable {
  const CreatePostCubitState();

  @override
  List<Object> get props => [];
}

class CreatePostCubitInitial extends CreatePostCubitState {}

class CreatingNewPost extends CreatePostCubitState {}

class ErrorState extends CreatePostCubitState {
  final String message;

  const ErrorState(this.message);
}

class PostCreatedSuccessfully extends CreatePostCubitState {
  final AddPostApiResponse apiResponse;

  const PostCreatedSuccessfully(this.apiResponse);
}
