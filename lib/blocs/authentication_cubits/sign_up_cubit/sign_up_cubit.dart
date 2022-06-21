import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/sign_up_api_response.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final Repository _repository = Repository();

  SignUpCubit() : super(SignUpInitial());

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    String? confirmPassword,
  }) async {
    final _formData = FormData.fromMap({
      'username': username,
      'email': email,
      'password': password,
      'confirm': confirmPassword
    });
    emit(LoadingState());
    final SignUpApiResponse apiResponse = await _repository.signUp(_formData);
    if (apiResponse.status == ApiResponse.success) {
      emit(SignUpSuccessFull(apiResponse.message ?? LocaleKeys.success.tr()));
    } else if (apiResponse.status == ApiResponse.failed &&
        apiResponse.data?.errorMessages != null) {
      emit(
        SignUpFailedState(
          message: apiResponse.message,
          textFieldMessages: apiResponse.data?.errorMessages,
        ),
      );
    } else {
      emit(
        SignUpFailedState(
          message: apiResponse.message,
        ),
      );
    }
  }
}
