part of 'create_story_cubit.dart';

abstract class CreateStoryCubitState extends Equatable {
  const CreateStoryCubitState();

  @override
  List<Object> get props => [];
}

class StoriesCubitInitial extends CreateStoryCubitState {}

class CreatingNewStory extends CreateStoryCubitState {}

class StoryCreatedSuccessfully extends CreateStoryCubitState {
  final CreateStroyApiResponse apiResponse;

  const StoryCreatedSuccessfully(this.apiResponse);
}

class ErrorState extends CreateStoryCubitState {
  final String message;

  const ErrorState(this.message);
}
