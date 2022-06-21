import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/get_user_preferences_api_response.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/models/data_models/user_preferences.dart';
import 'package:spott/utils/constants/api_constants.dart';

class UserPreferencesApiProvider {
  Future<UserPreferencesApiResponse> getUserPreferences(String _token) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio
          .get(ApiConstants.baseUrl + ApiConstants.getUserPreferencesUrl);
      if (response.statusCode == 200) {
        return UserPreferencesApiResponse.fromJson(response.data);
      } else {
        return UserPreferencesApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UserPreferencesApiResponse.fromJson(e.response?.data);
      } else {
        return UserPreferencesApiResponse(message: e.toString());
      }
    }
  }

  Future<UserPreferencesApiResponse> updateUserPreferences(
      String _token, UserPreferences _preferences) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $_token";
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.updateUserPreferencesUrl,
        data: FormData.fromMap(
          {
            'is_notifications': (_preferences.isNotifications ?? false) ? 1 : 0,
            'email_notifications':
                (_preferences.emailNotifications ?? false) ? 1 : 0,
            'chat_notifications':
                (_preferences.chatNotifications ?? false) ? 1 : 0,
            'nearby_spot_notifications':
                (_preferences.nearbySpotNotifications ?? false) ? 1 : 0,
            'radius': _preferences.radius,
            'profile_type': _preferences.profileType == ProfileType.private
                ? 'private'
                : 'public',
            'language': _preferences.language,
          },
        ),
      );
      if (response.statusCode == 200) {
        return UserPreferencesApiResponse.fromJson(response.data);
      } else {
        return UserPreferencesApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UserPreferencesApiResponse.fromJson(e.response?.data);
      } else {
        return UserPreferencesApiResponse(message: e.toString());
      }
    }
  }
}
