import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/edit_profile_api_response.dart';
import 'package:spott/models/api_responses/get_profile_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class ProfileApiProvider {
  Future<GetProfileApiResponse> getProfile(String token) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getUserProfileUrl,
      );
      if (response.statusCode == 200) {
        return GetProfileApiResponse.fromJson(response.data);
      } else {
        return GetProfileApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetProfileApiResponse.fromJson(e.response?.data);
      } else {
        return GetProfileApiResponse(message: e.toString());
      }
    }
  }

  Future<EditProfileApiResponse> editProfile(
      String token, FormData data) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.editUserProfileUrl,
          data: data);
      if (response.statusCode == 200) {
        return EditProfileApiResponse.fromJson(response.data);
      } else {
        return EditProfileApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return EditProfileApiResponse.fromJson(e.response?.data);
      } else {
        return EditProfileApiResponse(message: e.toString());
      }
    }
  }
}
