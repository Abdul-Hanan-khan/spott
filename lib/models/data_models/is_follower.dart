/// id : 25
/// user_id : 4
/// follower_id : 1
/// status : "accept"
/// created_at : "08, Oct 2021 12:01 PM"
/// updated_at : "2021-10-08T12:01:09.000000Z"

class IsFollower {
  int? _id;
  int? _userId;
  int? _followerId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get userId => _userId;
  int? get followerId => _followerId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  IsFollower({
      int? id, 
      int? userId, 
      int? followerId, 
      String? status, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _userId = userId;
    _followerId = followerId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  IsFollower.fromJson(dynamic json) {
    _id = json['id'] as int;
    _userId = json['user_id'] as int;
    _followerId = json['follower_id'] as int;
    _status = json['status'] as String;
    _createdAt = json['created_at'] as String;
    _updatedAt = json['updated_at'] as String;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['follower_id'] = _followerId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}