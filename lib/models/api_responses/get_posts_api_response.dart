import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/post.dart';

class GetPostsApiResponse extends GeneralApiResponse {
  List<Post>? _posts;

  List<Post>? get posts => _posts;

  GetPostsApiResponse({int? status, String? message, List<Post>? posts})
      : super(status: status, message: message) {
    _posts = posts;
  }

  GetPostsApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null && json["data"] != null) {
      _posts = [];
      json["data"].forEach((v) {
        _posts?.add(
          Post.fromJson(
            v,
          ),
        );
      });
    } else {
      print("error on $json");
    }
  }
}
