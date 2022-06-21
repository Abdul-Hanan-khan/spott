import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_user_preferences_api_response.dart';
import 'package:spott/models/api_responses/logout_api_response.dart';
import 'package:spott/models/data_models/user_preferences.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/preferences_controller.dart';

part 'settings_screen_state.dart';

class SettingsScreenCubit extends Cubit<SettingsScreenState> {
  final Repository _repository = Repository();

  SettingsScreenCubit() : super(SettingsScreenInitial());

  Future<void> getUserPreferences() async {
    if (AppData.accessToken != null) {
      emit(FetchingUserPreferences());
      final UserPreferencesApiResponse _apiResponse =
          await _repository.getUserPreferences(AppData.accessToken!);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.preferences != null) {
        emit(
          FetchedUserPreferencesSuccessfully(_apiResponse.preferences!),
        );
      } else {
        emit(
          ErrorState(
            _apiResponse.message ?? LocaleKeys.failedToGetUserPreferences.tr(),
          ),
        );
      }
    }
  }

  Future<void> logOutUser() async {
    if (AppData.accessToken != null) {
      emit(SignOutingUser());
      final LogoutApiResponse _apiResponse =
          await _repository.logoutUser(AppData.accessToken!);
      PreferencesController.signOutUser();
      if (_apiResponse.status == ApiResponse.success) {
        emit(const SignOutUser());
      } else {
        emit(
          SignOutUser(
              errorMessage:
                  _apiResponse.message ?? LocaleKeys.logoutFailed.tr()),
        );
      }
    }
  }

  Future<void> updateUserPreferences(UserPreferences _userPreferences) async {
    if (AppData.accessToken != null) {
      emit(UpdatingUserPreferences());
      final UserPreferencesApiResponse _apiResponse = await _repository
          .updateUserPreferences(AppData.accessToken!, _userPreferences);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.preferences != null) {
        emit(
          FetchedUserPreferencesSuccessfully(_apiResponse.preferences!),
        );
      } else {
        emit(
          ErrorState(_apiResponse.message ??
              LocaleKeys.failedToUpdateUserPreferences.tr()),
        );
      }
    }
  }
}
