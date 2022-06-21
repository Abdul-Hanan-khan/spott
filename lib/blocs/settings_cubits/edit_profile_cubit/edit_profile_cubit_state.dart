part of 'edit_profile_cubit.dart';

abstract class ProfileCubitState extends Equatable {
  const ProfileCubitState();

  @override
  List<Object> get props => [];
}

class ProfileCubitInitial extends ProfileCubitState {}

class FetchingProfile extends ProfileCubitState {}

class UpdatingProfile extends ProfileCubitState {}

class ErrorState extends ProfileCubitState {
  final String message;

  const ErrorState(this.message);
}

class ProfileFetchedSuccessFully extends ProfileCubitState {
  final User? user;

  const ProfileFetchedSuccessFully(this.user);
}

class ProfileUpdatedSuccessFully extends ProfileCubitState {
  final EditProfileApiResponse apiResponse;

  const ProfileUpdatedSuccessFully(this.apiResponse);
}
