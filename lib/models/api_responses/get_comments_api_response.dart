import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/comment.dart';

class GetCommentsApiResponse extends GeneralApiResponse {
  List<Comment>? _data;

  List<Comment>? get data => _data;

  GetCommentsApiResponse({int? status, String? message, List<Comment>? data})
      : super(status: status, message: message) {
    _data = data;
  }

  GetCommentsApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null && json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data?.add(Comment.fromJson(v));
      });
    }
  }
}
