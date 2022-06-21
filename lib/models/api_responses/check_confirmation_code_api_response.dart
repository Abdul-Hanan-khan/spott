// ignore_for_file: invalid_assignment
import 'package:spott/models/api_responses/general_api_response.dart';

class CheckConfirmationCodeApiResponse extends GeneralApiResponse {
  String? _data;

  String? get data => _data;

  CheckConfirmationCodeApiResponse({int? status, String? message, String? data})
      : super(status: status, message: message) {
    _data = data;
  }

  CheckConfirmationCodeApiResponse.fromJson(dynamic json)
      : super.fromJson(json) {
    if (json != null) {
      _data = json["data"];
    }
  }
}
