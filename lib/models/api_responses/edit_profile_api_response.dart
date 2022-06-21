import 'package:spott/models/data_models/user.dart';
import 'general_api_response.dart';

class EditProfileApiResponse extends GeneralApiResponse {
  User? _user;

  User? get user => _user;

  EditProfileApiResponse({int? status, String? message, User? user})
      : super(status: status, message: message) {
    _user = user;
  }

  EditProfileApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _user = User.fromJson(json['data']);
    }
  }
}
