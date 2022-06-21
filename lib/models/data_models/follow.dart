// ignore_for_file: invalid_assignment
import 'package:spott/models/data_models/user.dart';

enum FollowStatus {
  accept,
  pending,
  reject,
}

class Follow {
  int? _userId;
  String? _followerId;
  FollowStatus? _status;
  String? _updatedAt;
  String? _createdAt;
  int? _id;
  User? _follower;
  User? _following;

  int? get userId => _userId;
  String? get followerId => _followerId;
  FollowStatus? get status => _status;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;
  User? get follower => _follower;
  User? get following => _following;

  void requestAccepted() {
    _status = FollowStatus.accept;
  }

  void requestRejected() {
    _status = FollowStatus.reject;
  }

  Follow(
      {int? userId,
      String? followerId,
      FollowStatus? status,
      String? updatedAt,
      String? createdAt,
      int? id,
      User? follower,
      User? following}) {
    _userId = userId;
    _followerId = followerId;
    _status = status;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _follower = follower;
    _following = following;
  }

  Follow.fromJson(dynamic json) {
    if (json != null) {
      _userId = json["user_id"];
      _followerId = json["follower_id"].toString();
      _status = json["status"] != null
          ? FollowStatus.values.firstWhere(
              (e) => e.toString() == 'FollowStatus.${json["status"]}')
          : null;
      _updatedAt = json["updated_at"];
      _createdAt = json["created_at"];
      _id = json["id"];
      _follower = json['user'] != null ? User.fromJson(json['user']) : null;
      _follower ??=
          json['follower'] != null ? User.fromJson(json['follower']) : null;
      _following =
          json['following'] != null ? User.fromJson(json['following']) : null;
    }
  }
}
