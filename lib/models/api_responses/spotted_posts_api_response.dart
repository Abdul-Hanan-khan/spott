import 'package:spott/models/data_models/post.dart';

class SpottedPostsApiResponse {
  SpottedPostsApiResponse({
    int? status,
    String? message,
    List<Post>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  SpottedPostsApiResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Post.fromJson(v));
      });
    }
  }

  int? _status;
  String? _message;
  List<Post>? _data;

  int? get status => _status;

  String? get message => _message;

  List<Post>? get data => _data;
}
