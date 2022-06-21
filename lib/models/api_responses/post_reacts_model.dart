import 'package:spott/models/data_models/user.dart';

/// status : 1
/// data : [{"id":4,"user_id":1,"ref_id":2,"type":"post","react_key":2,"created_at":"2021-09-30T10:17:54.000000Z","updated_at":"2021-10-05T12:20:31.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}]

class PostReactsModel {
  int? _status;
  List<Data>? _data;

  int? get status => _status;
  List<Data>? get data => _data;

  PostReactsModel({
      int? status, 
      List<Data>? data}){
    _status = status;
    _data = data;
}

  PostReactsModel.fromJson(dynamic json) {
    _status = json['status'] as int;
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// user_id : 1
/// ref_id : 2
/// type : "post"
/// react_key : 2
/// created_at : "2021-09-30T10:17:54.000000Z"
/// updated_at : "2021-10-05T12:20:31.000000Z"
/// user : {"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}

class Data {
  int? _id;
  int? _userId;
  int? _refId;
  dynamic _type;
  int? _reactKey;
  dynamic _createdAt;
  dynamic _updatedAt;
  User? _user;

  int? get id => _id;
  int? get userId => _userId;
  int? get refId => _refId;
  dynamic get type => _type;
  int? get reactKey => _reactKey;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  User? get user => _user;

  Data({
      int? id, 
      int? userId, 
      int? refId, 
      dynamic type, 
      int? reactKey, 
      dynamic createdAt, 
      dynamic updatedAt, 
      User? user}){
    _id = id;
    _userId = userId;
    _refId = refId;
    _type = type;
    _reactKey = reactKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _id = json['id'] as int;
    _userId = json['user_id'] as int;
    _refId = json['ref_id'] as int;
    _type = json['type']  ;
    _reactKey = json['react_key'] as int;
    _createdAt = json['created_at']  ;
    _updatedAt = json['updated_at']  ;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['ref_id'] = _refId;
    map['type'] = _type;
    map['react_key'] = _reactKey;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 1
/// name : "Ali"
/// username : "ali"
/// email : "test@gmail.com"
/// phone : null
/// country : null
/// bio : null
/// city : null
/// address : null
/// lat : 37.4219758
/// lng : -122.0840214
/// email_verified_at : null
/// reset_code : null
/// type : "public"
/// social_login : null
/// isActive : 0
/// isBlocked : 0
/// expiry_date : null
/// profile_picture : null
/// cover_picture : null
/// rights : null
/// created_by : null
/// created_at : "2021-09-08T10:38:59.000000Z"
/// updated_at : "2021-09-08T11:03:48.000000Z"
/// notification_token : "a8d831f3-0342-491f-9b26-2c6a03252c13"

