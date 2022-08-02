// ignore_for_file: invalid_assignment
import 'package:spott/models/data_models/is_follower.dart';

enum ProfileType { private, public }

class User {
  int? _id;
  String? _name;
  String? _username;
  String? _email;
  dynamic _phone;
  String? _country;
  String? _bio;
  String? _city;
  String? _address;
  double? _lat;
  double? _lng;
  dynamic _resetCode;
  ProfileType? _type;
  String? _socialLogin;
  int? _isActive;
  int? _isBlocked;
  dynamic _expiryDate;
  String? _profilePicture;
  String? _coverPicture;
  dynamic _rights;
  dynamic _createdBy;
  String? _createdAt;
  String? _updatedAt;
  String? _notificationToken;
  int? _followersCount;
  int? _followingCount;
  int? _spotsCount;
  int? _placesCount;
  bool? storyyAvailable;
  IsFollower? _isFollower;

  int? get id => _id;

  String? get name => _name;

  String? get username => _username;

  String? get email => _email;

  dynamic get phone => _phone;

  String? get country => _country;

  String? get bio => _bio;

  String? get city => _city;

  String? get address => _address;

  double? get lat => _lat;

  double? get lng => _lng;

  dynamic get resetCode => _resetCode;

  ProfileType? get type => _type;

  int? get isActive => _isActive;

  int? get isBlocked => _isBlocked;

  dynamic get expiryDate => _expiryDate;

  String? get profilePicture => _profilePicture;

  String? get coverPicture => _coverPicture;

  dynamic get rights => _rights;

  dynamic get createdBy => _createdBy;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get socialLogin => _socialLogin;

  String? get notificationToken => _notificationToken;

  int? get followersCount => _followersCount;

  int? get followingCount => _followingCount;

  int? get spotsCount => _spotsCount;

  int? get placesCount => _placesCount;

  bool? get storyAvailable => storyyAvailable;

  IsFollower? get isFollower => _isFollower;

  void userFollowed() {
    _isFollower = IsFollower();
    _followersCount = (_followersCount ?? 0) + 1;
  }

  void userUnFollowed() {
    _isFollower = IsFollower();
    _followersCount = (_followersCount ?? 1) - 1;
  }

  User(
      {int? id,
      String? name,
      String? username,
      String? email,
      dynamic phone,
      String? country,
      String? bio,
      String? city,
      String? address,
      double? lat,
      double? lng,
      String? resetCode,
      ProfileType? type,
      int? isActive,
      int? isBlocked,
      dynamic expiryDate,
      String? profilePicture,
      dynamic coverPicture,
      dynamic rights,
      dynamic createdBy,
      String? createdAt,
      String? updatedAt,
      String? socialLogin,
      String? notificationToken,
      int? followersCount,
      int? followingCount,
      int? spotCount,
      int? placesCount,
      bool? storyAvailable,
      IsFollower? isFollower}) {
    _id = id;
    _name = name;
    _username = username;
    _email = email;
    _phone = phone;
    _country = country;
    _bio = bio;
    _city = city;
    _address = address;
    _lat = lat;
    _lng = lng;
    _resetCode = resetCode;
    _type = type;
    _isActive = isActive;
    _isBlocked = isBlocked;
    _expiryDate = expiryDate;
    _profilePicture = profilePicture;
    _coverPicture = coverPicture;
    _rights = rights;
    _createdBy = createdBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _socialLogin = socialLogin;
    _notificationToken = notificationToken;
    _followersCount = followersCount;
    _followingCount = followingCount;
    _spotsCount = spotCount;
    _placesCount = placesCount;
    storyyAvailable = storyAvailable;
    _isFollower = isFollower;
  }

  User.fromJson(dynamic json) {
    if (json != null) {
      _id = json["id"];
      _name = json["name"];
      _username = json["username"];
      _email = json["email"];
      _phone = json["phone"];
      _country = json["country"];
      _bio = json["bio"];
      _city = json["city"];
      _address = json["address"];
      _lat = ((json as Map).containsKey('lat'))
          ? ((json["lat"] is String)
              ? double.parse(json['lat'].toString())
              : json["lat"]?.toDouble())
          : null;
      _lng = (json.containsKey('lng'))
          ? ((json["lng"] is String)
              ? double.parse(json['lng'].toString())
              : json["lng"]?.toDouble())
          : null;
      _resetCode = json["reset_code"];
      _type = json["type"] != null
          ? ProfileType.values.firstWhere(
              (element) => element.toString() == 'ProfileType.${json["type"]}')
          : null;
      _isActive = json["isActive"];
      _isBlocked = json["isBlocked"];
      _expiryDate = json["expiry_date"];
      _profilePicture = json["profile_picture"];
      _coverPicture = json["cover_picture"];
      _rights = json["rights"];
      _createdBy = json["created_by"];
      _createdAt = json["created_at"];
      _updatedAt = json["updated_at"];
      _socialLogin = json['social_login'];
      _notificationToken = json["notification_token"];
      _followersCount = json["followers_count"];
      _followingCount = json["following_count"];
      _spotsCount = json["spots_count"];
      _placesCount = json["places_count"];
      storyyAvailable = json['story_available'];
      if (json["is_follower"] != null) {
        _isFollower = IsFollower.fromJson(json['is_follower']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["username"] = _username;
    map["email"] = _email;
    map["phone"] = _phone;
    map["country"] = _country;
    map["bio"] = _bio;
    map["city"] = _city;
    map["address"] = _address;
    map["lat"] = _lat;
    map["lng"] = _lng;
    map["type"] = _type == ProfileType.private ? 'private' : 'public';
    map["isActive"] = _isActive;
    map["isBlocked"] = _isBlocked;
    map["expiry_date"] = _expiryDate;
    map["profile_picture"] = _profilePicture;
    map["cover_picture"] = _coverPicture;
    map["rights"] = _rights;
    map["created_by"] = _createdBy;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    map['social_login'] = _socialLogin;
    map["notification_token"] = _notificationToken;
    map["followers_count"] = _followersCount;
    map["following_count"] = _followingCount;
    map["spots_count"] = _spotsCount;
    map["places_count"] = _placesCount;
    map['story_available'] = storyyAvailable;
    map["is_follower"] = _isFollower;
    return map;
  }
}
