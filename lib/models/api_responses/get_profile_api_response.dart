import 'package:spott/models/data_models/user.dart';
import 'general_api_response.dart';

class GetProfileApiResponse extends GeneralApiResponse {
  User? _user;

  User? get user => _user;

  GetProfileApiResponse({int? status, String? message, User? data})
      : super(status: status, message: message) {
    _user = data;
  }

  GetProfileApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _user = json["data"] != null ? User.fromJson(json["data"]) : null;
    }
  }
}
