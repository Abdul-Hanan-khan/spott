import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/login_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class SocialLoginApi {
  Future<LoginApiResponse> loginWithGoogle(String email) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.socialLogApi),
        body: {'email': email, 'provider': 'google'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return LoginApiResponse.fromJson(json.decode(response.body));
      } else {
        return LoginApiResponse(message: response.toString());
      }
    } catch (e) {
      print(e.toString());
      return LoginApiResponse(message: e.toString());
    }
  }
}
