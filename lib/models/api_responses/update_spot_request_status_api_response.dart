// ignore_for_file: invalid_assignment

import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/user.dart';

class UpdateSpotRequestStatusApiResponse extends GeneralApiResponse {
  Data? _data;

  Data? get data => _data;


  UpdateSpotRequestStatusApiResponse.fromJson(dynamic json)
      : super.fromJson(json) {
    if (json != null) {
      _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    }
  }
}

class Data {
  dynamic _id;
  dynamic _refId;
  dynamic _type;
  dynamic _userId;
  dynamic _status;
  dynamic _createdAt;
  dynamic _updatedAt;
  User? _user;
  Post? _post;

  dynamic get id => _id;
  dynamic get refId => _refId;
  dynamic get type => _type;
  dynamic get userId => _userId;
  dynamic get status => _status;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  User? get user => _user;
  Post? get post => _post;

  Data(
      {dynamic id,
      dynamic refId,
      dynamic type,
      dynamic userId,
      dynamic status,
      dynamic createdAt,
      dynamic updatedAt,
      User? user,
      Post? post,
      }) {
    _id = id;
    _refId = refId;
    _type = type;
    _userId = userId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _post = post;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _refId = json["ref_id"];
    _type = json["type"];
    _userId = json["user_id"];
    _status = json["status"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _post = json["ref"] != null ? Post.fromJson(json["ref"]) : null;
  }
}
