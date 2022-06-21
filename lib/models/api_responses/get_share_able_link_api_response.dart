// ignore_for_file: invalid_assignment
import 'package:spott/models/api_responses/general_api_response.dart';

class GetShareAbleLinkApiResponse extends GeneralApiResponse {
  String? _link;

  String? get link => _link;

  GetShareAbleLinkApiResponse({int? status, String? message, String? data})
      : super(status: status, message: message) {
    _link = data;
  }

  GetShareAbleLinkApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    _link = json['data'];
  }
}
