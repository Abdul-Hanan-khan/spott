import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/sign_up_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class SignUpApiProvider {
  Future<SignUpApiResponse> signUp(FormData _data) async {
    try {
      final Dio dio = Dio();
      final Response response = await dio
          .post(ApiConstants.baseUrl + ApiConstants.signUpUrl, data: _data);
      if (response.statusCode == 200) {
        return SignUpApiResponse.fromJson(response.data);
      } else {
        return SignUpApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return SignUpApiResponse.fromJson(e.response?.data);
      } else {
        return SignUpApiResponse(message: e.toString());
      }
    }
  }
}
