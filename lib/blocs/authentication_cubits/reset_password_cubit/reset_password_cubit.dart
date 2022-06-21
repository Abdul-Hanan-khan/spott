import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/check_confirmation_code_api_response.dart';
import 'package:spott/models/api_responses/send_reset_password_email_api_response.dart';
import 'package:spott/models/api_responses/update_password_api_response.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'reset_password_cubit_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordCubitState> {
  final Repository _repository = Repository();

  ResetPasswordCubit() : super(ResetPasswordCubitInitial());

  Future<void> checkConfirmationCode(String _email, String _code) async {
    emit(LoadingState());
    final CheckConfirmationCodeApiResponse apiResponse =
        await _repository.checkConfirmationCode(_email, _code);
    if (apiResponse.status == ApiResponse.success) {
      emit(ConfirmationCodeIsValid(_email, _code, message: apiResponse.data));
    } else {
      emit(
        PasswordResetFailedState(
          apiResponse.message ?? LocaleKeys.confirmationCodeIncorrect.tr(),
        ),
      );
    }
  }

  Future<void> sendResetPasswordEmail(String _email) async {
    emit(LoadingState());
    final SendResetPasswordEmailApiResponse apiResponse =
        await _repository.sendResetPasswordEmail(_email);
    if (apiResponse.status == ApiResponse.success) {
      emit(ResetPasswordEmailSent(_email, message: apiResponse.data));
    } else {
      emit(
        PasswordResetFailedState(
          apiResponse.message ?? LocaleKeys.failedTOSendEmail.tr(),
        ),
      );
    }
  }

  Future<void> updateUserPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    emit(LoadingState());
    final UpdatePasswordApiResponse apiResponse = await _repository
        .updatePassword(email: email, code: code, password: password);
    if (apiResponse.status == ApiResponse.success) {
      emit(PasswordUpdatedSuccessfully());
    } else {
      emit(
        PasswordResetFailedState(
          apiResponse.message ?? LocaleKeys.passwordResetFailed.tr(),
        ),
      );
    }
  }
}
