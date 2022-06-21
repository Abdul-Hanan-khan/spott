import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/user.dart';

class UpdateUserNotificationTokenApiResponse extends GeneralApiResponse {
  User? _user;

  User? get user => _user;

  UpdateUserNotificationTokenApiResponse(
      {int? status, String? message, User? user})
      : super(status: status, message: message) {
    _user = user;
  }

  UpdateUserNotificationTokenApiResponse.fromJson(dynamic json)
      : super.fromJson(json) {
    if (json != null) {
      _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    }
  }
}
