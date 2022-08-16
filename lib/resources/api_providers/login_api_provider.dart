import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/login_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class LoginApiProvider {
  Future<LoginApiResponse> loginUser(String _email, String _password) async {
    try {
      final _data = FormData.fromMap({
        'email': _email,
        'password': _password,
      });
      final dio = Dio();
      final Response response = await dio
          .post(ApiConstants.baseUrl + ApiConstants.loginUrl, data: _data);

      if (response.statusCode == 200) {
        String userId;
        userId = (response.data)["data"]['user']["id"].toString();

        FirebaseFirestore.instance
            .collection('users')
            .doc(userId.toString())
            .set({'userState': 0, 'isNewMessage': 0});

        return LoginApiResponse.fromJson(response.data);
      } else {
        return LoginApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return LoginApiResponse.fromJson(e.response?.data);
      } else {
        return LoginApiResponse(message: e.toString());
      }
    }
  }
}
