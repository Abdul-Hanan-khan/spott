import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';

class UserAllStoryApiResponse {
  UserAllStoryApiResponse({
    String? message,
    int? status,
    List<Posts>? posts,
  }) {
    _message = message;
    _status = status;
    _posts = posts;
  }

  UserAllStoryApiResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['posts'] != null) {
      _posts = [];
      json['posts'].forEach((v) {
        _posts?.add(Posts.fromJson(v));
      });
    }
  }

  String? _message;
  int? _status;
  List<Posts>? _posts;

  String? get message => _message;

  int? get status => _status;

  List<Posts>? get posts => _posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_posts != null) {
      map['posts'] = _posts?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Posts {
  Posts({
    int? id,
    int? userId,
    String? type,
    String? content,
    double? lat,
    double? lng,
    String? address,
    String? placeId,
    String? placeType,
    int? status,
    String? privacy,
    List<String>? media,
    int? views,
    String? createdAt,
    String? updatedAt,
    int? spotsCount,
    User? user,
    dynamic spot,
    Place? place,
  }) {
    _id = id;
    _userId = userId;
    _type = type;
    _content = content;
    _lat = lat;
    _lng = lng;
    _address = address;
    _placeId = placeId;
    _placeType = placeType;
    _status = status;
    _privacy = privacy;
    _media = media;
    _views = views;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _spotsCount = spotsCount;
    _user = user;
    _spot = spot;
    _place = place;
  }

  Posts.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _type = json['type'];
    _content = json['content'];
    _lat = json['lat'];
    _lng = json['lng'];
    _address = json['address'];
    _placeId = json['place_id'];
    _placeType = json['place_type'];
    _status = json['status'];
    _privacy = json['privacy'];
    _media = json['media'] != null ? json['media'].cast<String>() : [];
    _views = json['views'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _spotsCount = json['spots_count'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _spot = json['spot'];
    _place = json['place'] != null ? Place.fromJson(json['place']) : null;
  }

  int? _id;
  int? _userId;
  String? _type;
  String? _content;
  double? _lat;
  double? _lng;
  String? _address;
  String? _placeId;
  String? _placeType;
  int? _status;
  String? _privacy;
  List<String>? _media;
  int? _views;
  String? _createdAt;
  String? _updatedAt;
  int? _spotsCount;
  User? _user;
  dynamic _spot;
  Place? _place;

  int? get id => _id;

  int? get userId => _userId;

  String? get type => _type;

  String? get content => _content;

  double? get lat => _lat;

  double? get lng => _lng;

  String? get address => _address;

  String? get placeId => _placeId;

  String? get placeType => _placeType;

  int? get status => _status;

  String? get privacy => _privacy;

  List<String>? get media => _media;

  int? get views => _views;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  int? get spotsCount => _spotsCount;

  User? get user => _user;

  dynamic get spot => _spot;

  Place? get place => _place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['type'] = _type;
    map['content'] = _content;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['address'] = _address;
    map['place_id'] = _placeId;
    map['place_type'] = _placeType;
    map['status'] = _status;
    map['privacy'] = _privacy;
    map['media'] = _media;
    map['views'] = _views;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['spots_count'] = _spotsCount;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['spot'] = _spot;
    if (_place != null) {
      map['place'] = _place?.toJson();
    }
    return map;
  }
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


class Is_follower {
  Is_follower({
    int? id,
    int? userId,
    int? followerId,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _followerId = followerId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Is_follower.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _followerId = json['follower_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['follower_id'] = _followerId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
