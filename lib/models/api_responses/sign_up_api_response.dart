// ignore_for_file:argument_type_not_assignable
import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/user.dart';

class SignUpApiResponse extends GeneralApiResponse {
  Data? _data;

  Data? get data => _data;

  SignUpApiResponse({int? status, String? message, Data? data})
      : super(status: status, message: message) {
    _data = data;
  }

  SignUpApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    }
  }
}

class Data {
  User? _user;
  SignUpErrorMessages? _errorMessages;

  User? get user => _user;
  SignUpErrorMessages? get errorMessages => _errorMessages;

  Data({User? user, SignUpErrorMessages? errorMessages}) {
    _user = user;
    _errorMessages = errorMessages;
  }

  Data.fromJson(dynamic json) {
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _errorMessages = SignUpErrorMessages.fromJson(json['error']);
  }
}

class SignUpErrorMessages {
  List<String>? _userName;
  List<String>? _name;
  List<String>? _email;
  List<String>? _password;

  List<String>? get userName => _userName;
  List<String>? get name => _name;
  List<String>? get email => _email;
  List<String>? get password => _password;

  SignUpErrorMessages(
      {List<String>? username,
      List<String>? name,
      List<String>? email,
      List<String>? password}) {
    _userName = username;
    _name = name;
    _email = email;
    _password = password;
  }

  SignUpErrorMessages.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      if (json["username"] != null) {
        _userName = [];
        json["username"].forEach((value) {
          _userName!.add(value);
        });
      }
      if (json["name"] != null) {
        _name = [];
        json["name"].forEach((value) {
          _name!.add(value);
        });
      }
      if (json["email"] != null) {
        _email = [];
        json["email"].forEach((value) {
          _email!.add(value);
        });
      }
      if (json["password"] != null) {
        _password = [];
        json["password"].forEach((value) {
          _password!.add(value);
        });
      }
    }
  }
}
