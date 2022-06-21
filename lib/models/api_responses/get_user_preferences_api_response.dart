import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/user_preferences.dart';

class UserPreferencesApiResponse extends GeneralApiResponse {
  UserPreferences? _preferences;

  UserPreferences? get preferences => _preferences;

  UserPreferencesApiResponse(
      {int? status, String? message, UserPreferences? preferences})
      : super(status: status, message: message) {
    _preferences = preferences;
  }

  UserPreferencesApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _preferences = json["preferences"] != null
          ? UserPreferences.fromJson(json["preferences"])
          : null;
    }
  }
}
