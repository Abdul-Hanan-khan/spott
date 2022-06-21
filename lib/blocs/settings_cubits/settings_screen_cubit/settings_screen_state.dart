part of 'settings_screen_cubit.dart';

abstract class SettingsScreenState extends Equatable {
  const SettingsScreenState();

  @override
  List<Object> get props => [];
}

class SettingsScreenInitial extends SettingsScreenState {}

class FetchingUserPreferences extends SettingsScreenState {}

class UpdatingUserPreferences extends SettingsScreenState {}

class ErrorState extends SettingsScreenState {
  final String message;

  const ErrorState(this.message);
}

class FetchedUserPreferencesSuccessfully extends SettingsScreenState {
  final UserPreferences userPreferences;

  const FetchedUserPreferencesSuccessfully(this.userPreferences);
}

class SignOutingUser extends SettingsScreenState {}

class SignOutUser extends SettingsScreenState {
  final String? errorMessage;

  const SignOutUser({this.errorMessage});
}
