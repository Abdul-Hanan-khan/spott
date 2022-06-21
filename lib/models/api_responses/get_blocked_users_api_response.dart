import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/user.dart';

class GetBlockedUsersApiResponse extends GeneralApiResponse {
  List<User>? _users;

  List<User>? get users => _users;

  GetBlockedUsersApiResponse({int? status, String? message, List<User>? users})
      : super(status: status, message: message) {
    _users = users;
  }

  GetBlockedUsersApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null && json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users?.add(User.fromJson(v));
      });
    }
  }
}
