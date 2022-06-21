// ignore_for_file: invalid_assignment
import 'package:spott/models/data_models/user.dart';
import 'general_api_response.dart';

class LoginApiResponse extends GeneralApiResponse {
  _Data? _data;

  _Data? get data => _data;

   LoginApiResponse({int? status, String? message, _Data? data})
      : super(status: status, message: message) {
    _data = data;
  }

  LoginApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _data = json["data"] != null ? _Data.fromJson(json["data"]) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data?.toJson();
    return map;
  }
}

class _Data {
  String? _accessToken;
  String? _tokenType;
  User? _user;
  String? _expiresAt;

  String? get accessToken => _accessToken;
  String? get tokenType => _tokenType;
  User? get user => _user;
  String? get expiresAt => _expiresAt;

  _Data(
      {String? accessToken, String? tokenType, User? user, String? expiresAt}) {
    _accessToken = accessToken;
    _tokenType = tokenType;
    _user = user;
    _expiresAt = expiresAt;
  }

  _Data.fromJson(dynamic json) {
    _accessToken = json["access_token"];
    _tokenType = json["token_type"];
    _user = User.fromJson(json["user"]);
    _expiresAt = json["expires_at"];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['token_type'] = _tokenType;
    map['user'] = _user?.toJson();
    map['expires_at'] = _expiresAt;
    return map;
  }
}
