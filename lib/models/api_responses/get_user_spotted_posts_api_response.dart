import 'package:spott/models/data_models/post.dart';
import 'general_api_response.dart';

class GetUserSpottedPostsApiResponse extends GeneralApiResponse {
  List<Post>? _posts;

  List<Post>? get posts => _posts;

  GetUserSpottedPostsApiResponse(
      {int? status, String? message, List<Post>? posts})
      : super(status: status, message: message) {
    _posts = posts;
  }

  GetUserSpottedPostsApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      if (json['posts'] != null) {
        _posts = [];
        json['posts'].forEach((item) {
          _posts?.add(Post.fromJson(item));
        });
      }
    }
  }
}
