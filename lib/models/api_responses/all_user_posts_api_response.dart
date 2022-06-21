import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/models/data_models/post.dart';

class AllUserPostsApiResponse {
  AllUserPostsApiResponse({
    String? message,
    int? status,
    List<Post>? posts,
  }) {
    _message = message;
    _status = status;
    _posts = posts;
  }

  AllUserPostsApiResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['posts'] != null) {
      _posts = [];
      json['posts'].forEach((v) {
        _posts?.add(Post.fromJson(v));
      });
    }
  }

  String? _message;
  int? _status;
  List<Post>? _posts;

  String? get message => _message;

  int? get status => _status;

  List<Post>? get posts => _posts;

}



class Followers {
  Followers({
    int? id,
    int? placeId,
    int? userId,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) {
    _id = id;
    _placeId = placeId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
  }

  Followers.fromJson(dynamic json) {
    _id = json['id'];
    _placeId = json['place_id'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  int? _id;
  int? _placeId;
  int? _userId;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  int? get id => _id;

  int? get placeId => _placeId;

  int? get userId => _userId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['place_id'] = _placeId;
    map['user_id'] = _userId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
