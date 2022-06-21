// ignore_for_file: invalid_assignment
import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/follow.dart';
import 'package:spott/utils/constants/api_constants.dart';

class FollowUserApiResponse extends GeneralApiResponse {
  Follow? _follow;

  Follow? get follow => _follow;

  FollowUserApiResponse({int? status, String? message, Follow? data})
      : super(status: status, message: message) {
    _follow = data;
  }

  FollowUserApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (status == ApiResponse.success) {
      _follow = json["data"] != null ? Follow.fromJson(json["data"]) : null;
    }
  }
}
