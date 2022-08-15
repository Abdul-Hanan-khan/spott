import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
        String userId;
        print(response.body);
       userId= json.decode(response.body)["data"]['user']["id"].toString();



        FirebaseFirestore.instance
            .collection('users')
            .doc(userId.toString())
            .set({
          'userState': 0,
          'isNewMessage': 0
        });

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
