import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/logout_api_response.dart';
import 'package:spott/resources/services/google_sign_in_service.dart';
import 'package:spott/utils/constants/api_constants.dart';

class LogoutApiProvider {
  Future<LogoutApiResponse> logoutUser(String _token) async {
    try {
      GoogleSignInService.signOut();
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.logoutUrl);
      if (response.statusCode == 200) {
        return LogoutApiResponse.fromJson(response.data);
      } else {
        return LogoutApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return LogoutApiResponse.fromJson(e.response?.data);
      } else {
        return LogoutApiResponse(message: e.toString());
      }
    }
  }
}
