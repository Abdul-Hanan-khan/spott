import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spott/models/api_responses/login_api_response.dart';
import 'package:spott/resources/services/google_sign_in_service.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

class SocialLoginApiProvider {
  // Future<LoginApiResponse> signInUserWithGoogle() async {
  //   // try {
  //   //   final GoogleSignInAccount? _googleAccount =
  //   //       await GoogleSignInService.login();
  //   //   if (_googleAccount != null) {
  //   //     final _googleAuthentication = await _googleAccount.authentication;
  //   //     final FormData _data = FormData.fromMap(
  //   //         {'access_token': _googleAuthentication.accessToken});
  //   //     final Dio dio = Dio();
  //   //     final Response response = await dio.post(
  //   //         ApiConstants.baseUrl + ApiConstants.signInWithGoogleUrl,
  //   //         data: _data);
  //   //     if (response.statusCode == 200) {
  //   //       return LoginApiResponse.fromJson(response.data);
  //   //     } else {
  //   //       return LoginApiResponse(message: response.toString());
  //   //     }
  //   //   } else {
  //   //     return LoginApiResponse(
  //   //         message: LocaleKeys.signInWithGoogleFailed.tr());
  //   //   }
  //   // } catch (e) {
  //   //   if (e is DioError) {
  //   //     return LoginApiResponse.fromJson(e.response?.data);
  //   //   } else if (e is PlatformException) {
  //   //     return LoginApiResponse(message: e.message);
  //   //   } else {
  //   //     return LoginApiResponse(message: e.toString());
  //   //   }
  //   // }
  // }
}
