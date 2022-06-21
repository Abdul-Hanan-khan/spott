import 'package:spott/models/data_models/post.dart';
import 'general_api_response.dart';

class CreateStroyApiResponse extends GeneralApiResponse {
  Post? _data;

  Post? get post => _data;

  CreateStroyApiResponse({int? status, String? message, Post? data})
      : super(status: status, message: message) {
    _data = data;
  }

  CreateStroyApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _data = json["data"] != null ? Post.fromJson(json["data"]) : null;
    }
  }
}
