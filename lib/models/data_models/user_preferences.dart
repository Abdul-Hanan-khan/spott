// ignore_for_file: invalid_assignment
import 'package:flutter/foundation.dart';
import 'package:spott/models/data_models/user.dart';

class UserPreferences {
  int? _id;
  int? _userId;
  bool? _isNotifications;
  bool? _emailNotifications;
  bool? _chatNotifications;
  bool? _nearbySpotNotifications;
  double? _radius;
  ProfileType? _profileType;
  String? _language;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get userId => _userId;
  bool? get isNotifications => _isNotifications;
  bool? get emailNotifications => _emailNotifications;
  bool? get chatNotifications => _chatNotifications;
  bool? get nearbySpotNotifications => _nearbySpotNotifications;
  double? get radius => _radius;
  ProfileType? get profileType => _profileType;
  String? get language => _language;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  UserPreferences(
      {int? id,
      int? userId,
      bool? isNotifications,
      bool? emailNotifications,
      bool? chatNotifications,
      bool? nearbySpotNotifications,
      double? radius,
      ProfileType? profileType,
      String? language,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _userId = userId;
    _isNotifications = isNotifications;
    _emailNotifications = emailNotifications;
    _chatNotifications = chatNotifications;
    _nearbySpotNotifications = nearbySpotNotifications;
    _radius = radius;
    _profileType = profileType;
    _language = language;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserPreferences.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _isNotifications = json["is_notifications"] == 1;
    _emailNotifications = json["email_notifications"] == 1;
    _chatNotifications = json["chat_notifications"] == 1;
    _nearbySpotNotifications = json["nearby_spot_notifications"] == 1;
    try {
      _radius = json["radius"] != null
          ? double.parse(json["radius"].toString())
          : null;
    } catch (e) {
      debugPrint(e.toString());
    }
    _profileType = json["profile_type"] != null
        ? ProfileType.values.firstWhere((element) =>
            element.toString() == 'ProfileType.${json["profile_type"]}')
        : null;
    _language = json["language"] as String?;
    _createdAt = json["created_at"] as String?;
    _updatedAt = json["updated_at"] as String?;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["is_notifications"] = (_isNotifications ?? false) ? 1 : 0;
    map["email_notifications"] = (_emailNotifications ?? false) ? 1 : 0;
    map["chat_notifications"] = (_chatNotifications ?? false) ? 1 : 0;
    map["nearby_spot_notifications"] =
        (_nearbySpotNotifications ?? false) ? 1 : 0;
    map["radius"] = _radius;
    map["profile_type"] =
        _profileType == ProfileType.private ? 'private' : 'public';
    map["language"] = _language;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
