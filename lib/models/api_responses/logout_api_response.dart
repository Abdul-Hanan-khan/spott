// ignore_for_file: invalid_assignment
import 'package:spott/models/api_responses/general_api_response.dart';

class LogoutApiResponse extends GeneralApiResponse {
  String? _data;

  String? get data => _data;

  LogoutApiResponse({int? status, String? message, String? data})
      : super(status: status, message: message) {
    _data = data;
  }

  LogoutApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _data = json["data"];
    }
  }
}
