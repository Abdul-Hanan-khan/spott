/// message : "Follow successful"
/// status : 1
/// place_follower : {"user_id":1,"place_id":"5","updated_at":"2021-10-13T06:55:34.000000Z","created_at":"2021-10-13T06:55:34.000000Z","id":4}

class PlaceFollowApiModel {
  dynamic _message;
  dynamic _status;
  Place_follower? _placeFollower;

  dynamic get message => _message;
  dynamic get status => _status;
  Place_follower? get placeFollower => _placeFollower;

  PlaceFollowApiModel(
      {dynamic message, dynamic status, Place_follower? placeFollower}) {
    _message = message;
    _status = status;
    _placeFollower = placeFollower;
  }

  PlaceFollowApiModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    // _placeFollower = json['place_follower'] != null
    //     ? Place_follower.fromJson(json['placeFollower'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_placeFollower != null) {
      map['place_follower'] = _placeFollower?.toJson();
    }
    return map;
  }
}

/// user_id : 1
/// place_id : "5"
/// updated_at : "2021-10-13T06:55:34.000000Z"
/// created_at : "2021-10-13T06:55:34.000000Z"
/// id : 4

class Place_follower {
  dynamic _userId;
  dynamic _placeId;
  dynamic _updatedAt;
  dynamic _createdAt;
  dynamic _id;

  dynamic get userId => _userId;
  dynamic get placeId => _placeId;
  dynamic get updatedAt => _updatedAt;
  dynamic get createdAt => _createdAt;
  dynamic get id => _id;

  Place_follower(
      {dynamic userId,
      dynamic placeId,
      dynamic updatedAt,
      dynamic createdAt,
      dynamic id}) {
    _userId = userId;
    _placeId = placeId;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Place_follower.fromJson(dynamic json) {
    _userId = json['user_id'];
    _placeId = json['place_id'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['place_id'] = _placeId;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }
}
