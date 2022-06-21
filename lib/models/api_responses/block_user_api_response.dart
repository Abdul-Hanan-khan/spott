// ignore_for_file: invalid_assignment

import 'general_api_response.dart';

class BlockUserApiResponse extends GeneralApiResponse {
  Blocked? _blocked;

  Blocked? get blocked => _blocked;

  BlockUserApiResponse({int? status, String? message, Blocked? blocked})
      : super(status: status, message: message) {
    _blocked = blocked;
  }

  BlockUserApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _blocked =
          json["blocked"] != null ? Blocked.fromJson(json["blocked"]) : null;
    }
  }
}

class Blocked {
  List<int>? _users;
  String? _ref;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  List<int>? get users => _users;
  String? get ref => _ref;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Blocked(
      {List<int>? users,
      String? ref,
      String? updatedAt,
      String? createdAt,
      int? id}) {
    _users = users;
    _ref = ref;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Blocked.fromJson(dynamic json) {
    _users = json["users"] != null ? json["users"].cast<int>() : [];
    _ref = json["ref"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }
}
