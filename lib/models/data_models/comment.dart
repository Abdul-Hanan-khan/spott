// ignore_for_file: invalid_assignment
// ignore_for_file:argument_type_not_assignable
import 'package:spott/models/data_models/user.dart';

class Comment {
  int? _id;
  int? _userId;
  int? _postId;
  String? _comment;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  User? _user;

  int? get id => _id;
  int? get userId => _userId;
  int? get postId => _postId;
  String? get comment => _comment;
  User? get user => _user;
  DateTime? get createdAt => _createdAt;
  DateTime? get updatedAt => _updatedAt;

  Comment(
      {int? id,
      int? userId,
      int? postId,
      String? comment,
      User? user,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    _id = id;
    _userId = userId;
    _postId = postId;
    _comment = comment;
    _user = user;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Comment.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json["user_id"];
    _postId = json['post_id'];
    _comment = json["comment"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _createdAt =
        json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
    _updatedAt =
        json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
  }
}
