import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/comment.dart';

class AddCommentApiResponse extends GeneralApiResponse {
  Comment? _comment;

  Comment? get comment => _comment;

  AddCommentApiResponse({int? status, String? message, Comment? data})
      : super(status: status, message: message) {
    _comment = data;
  }

  AddCommentApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _comment = json["data"] != null ? Comment.fromJson(json["data"]) : null;
    }
  }
}
