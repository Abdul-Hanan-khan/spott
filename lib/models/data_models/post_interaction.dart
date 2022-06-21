// ignore_for_file: invalid_assignment
import 'user.dart';

class PostInteraction {
  int? _id;
  int? _userId;
  int? _postId;
  String? _type;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  int? get id => _id;
  int? get userId => _userId;
  int? get postId => _postId;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;

  PostInteraction(
      {int? id,
      int? userId,
      int? postId,
      String? type,
      String? createdAt,
      String? updatedAt,
      User? user}) {
    _id = id;
    _userId = userId;
    _postId = postId;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
  }

  PostInteraction.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _postId = json["post_id"];
    _type = json["type"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }
}
