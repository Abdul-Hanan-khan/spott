import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/change_password_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'change_password_cubit_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordCubitState> {
  final Repository _repository = Repository();

  ChangePasswordCubit() : super(ChangePasswordCubitInitial());

  Future<void> changePassword(String _oldPassword, String _newPassword) async {
    if (AppData.accessToken != null) {
      emit(ChangingPassword());
      final ChangePasswordApiResponse apiResponse =
          await _repository.changePassword(
        token: AppData.accessToken!,
        oldPassword: _oldPassword,
        newPassword: _newPassword,
      );
      if (apiResponse.status == ApiResponse.success) {
        emit(PasswordChangedSuccessFully(apiResponse.message));
      } else {
        emit(
          FailedToChangePassword(
            apiResponse.message ?? LocaleKeys.passwordResetFailed.tr(),
          ),
        );
      }
    }
  }
}
