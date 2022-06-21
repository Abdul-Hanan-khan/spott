import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/change_password_api_response.dart';
import 'package:spott/models/api_responses/check_confirmation_code_api_response.dart';
import 'package:spott/models/api_responses/send_reset_password_email_api_response.dart';
import 'package:spott/models/api_responses/update_password_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class ResetPasswordApiProvider {
  Future<SendResetPasswordEmailApiResponse> sendResetPasswordEmail(
      String _email) async {
    try {
      final _data = FormData.fromMap({
        'email': _email,
      });
      final Dio dio = Dio();
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.sendResetPasswordEmailUrl,
          data: _data);
      if (response.statusCode == 200) {
        return SendResetPasswordEmailApiResponse.fromJson(response.data);
      } else {
        return SendResetPasswordEmailApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return SendResetPasswordEmailApiResponse.fromJson(e.response?.data);
      } else {
        return SendResetPasswordEmailApiResponse(message: e.toString());
      }
    }
  }

  Future<CheckConfirmationCodeApiResponse> checkConfirmationCode(
      String _email, String _code) async {
    try {
      final _data = FormData.fromMap({
        'email': _email,
        'code': _code,
      });
      final Dio dio = Dio();
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.checkConfirmationCOdeUrl,
          data: _data);
      if (response.statusCode == 200) {
        return CheckConfirmationCodeApiResponse.fromJson(response.data);
      } else {
        return CheckConfirmationCodeApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return CheckConfirmationCodeApiResponse.fromJson(e.response?.data);
      } else {
        return CheckConfirmationCodeApiResponse(message: e.toString());
      }
    }
  }

  Future<UpdatePasswordApiResponse> updatePassword(
      {required String email,
      required String code,
      required String password}) async {
    try {
      final _data = FormData.fromMap({
        'email': email,
        'code': code,
        'password': password,
      });
      final Dio dio = Dio();
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.updatePasswordUrl,
          data: _data);
      if (response.statusCode == 200) {
        return UpdatePasswordApiResponse.fromJson(response.data);
      } else {
        return UpdatePasswordApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UpdatePasswordApiResponse.fromJson(e.response?.data);
      } else {
        return UpdatePasswordApiResponse(message: e.toString());
      }
    }
  }

//! will update user password using old password
  Future<ChangePasswordApiResponse> changePassword(
      {required String token,
      required String oldPassword,
      required String newPassword}) async {
    try {
      final _data = FormData.fromMap({
        'old_password': oldPassword,
        'new_password': newPassword,
      });
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.changePasswordApiUrl,
          data: _data);
      if (response.statusCode == 200) {
        return ChangePasswordApiResponse.fromJson(response.data);
      } else {
        return ChangePasswordApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return ChangePasswordApiResponse.fromJson(e.response?.data);
      } else {
        return ChangePasswordApiResponse(message: e.toString());
      }
    }
  }
}
