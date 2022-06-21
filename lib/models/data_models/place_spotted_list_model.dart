import 'package:spott/models/data_models/user.dart';

/// status : 1
/// message : "success"
/// data : [{"id":2,"ref_id":1,"type":"post","user_id":2,"status":"accept","created_at":"2021-09-08T14:13:03.000000Z","updated_at":"2021-09-28T07:45:07.000000Z","user":{"id":2,"name":null,"username":"test","email":"test@email.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":null,"lng":null,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T14:12:18.000000Z","updated_at":"2021-09-08T14:12:18.000000Z","notification_token":"e2a27c7a-aa2a-4255-98ad-e60ffeba9558"}},{"id":11,"ref_id":1,"type":"post","user_id":6,"status":"pending","created_at":"2021-09-20T12:30:31.000000Z","updated_at":"2021-09-20T12:30:31.000000Z","user":{"id":6,"name":"Asad","username":"Asad","email":"asd@gmail.com","phone":null,"country":null,"bio":"Hi There","city":null,"address":null,"lat":31.5073867,"lng":74.2780796,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":"https://grosre.com/uploads/uploads/users/2021/09/1631864663-6-59.png","rights":null,"created_by":null,"created_at":"2021-09-17T07:42:18.000000Z","updated_at":"2021-09-17T07:44:23.000000Z","notification_token":"e4267225-2d6a-498d-9be7-76961b7223dc"}},{"id":17,"ref_id":1,"type":"post","user_id":7,"status":"accept","created_at":"2021-09-28T11:44:06.000000Z","updated_at":"2021-09-28T12:07:04.000000Z","user":{"id":7,"name":"kashif","username":"Ali12","email":"ali@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":31.5074149,"lng":74.2781251,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-19T02:43:02.000000Z","updated_at":"2021-09-28T11:53:57.000000Z","notification_token":"9cd16a0d-6cb5-4b78-9d80-24bad4164175"}}]

class PlaceSpottedListModel {
  int? _status;
  String? _message;
  List<Data>? _data;

  int? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  PlaceSpottedListModel({
      int? status, 
      String? message, 
      List<Data>? data}){
    _status = status;
    _message = message;
    _data = data;
}

  PlaceSpottedListModel.fromJson(dynamic json) {
    _status = json['status'] as int;
    _message = json['message'] as String;
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
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// ref_id : 1
/// type : "post"
/// user_id : 2
/// status : "accept"
/// created_at : "2021-09-08T14:13:03.000000Z"
/// updated_at : "2021-09-28T07:45:07.000000Z"
/// user : {"id":2,"name":null,"username":"test","email":"test@email.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":null,"lng":null,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T14:12:18.000000Z","updated_at":"2021-09-08T14:12:18.000000Z","notification_token":"e2a27c7a-aa2a-4255-98ad-e60ffeba9558"}

class Data {
  int? _id;
  int? _refId;
  String? _type;
  int? _userId;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  int? get id => _id;
  int? get refId => _refId;
  String? get type => _type;
  int? get userId => _userId;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;

  Data({
      int? id, 
      int? refId, 
      String? type, 
      int? userId, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      User? user}){
    _id = id;
    _refId = refId;
    _type = type;
    _userId = userId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Data.fromJson(dynamic json) {
    _id = json['id'] as int;
    _refId = json['ref_id'] as int;
    _type = json['type'] as String;
    _userId = json['user_id'] as int;
    _status = json['status'] as String;
    _createdAt = json['created_at'] as String;
    _updatedAt = json['updated_at'] as String;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['ref_id'] = _refId;
    map['type'] = _type;
    map['user_id'] = _userId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// id : 2
/// name : null
/// username : "test"
/// email : "test@email.com"
/// phone : null
/// country : null
/// bio : null
/// city : null
/// address : null
/// lat : null
/// lng : null
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
/// created_at : "2021-09-08T14:12:18.000000Z"
/// updated_at : "2021-09-08T14:12:18.000000Z"
/// notification_token : "e2a27c7a-aa2a-4255-98ad-e60ffeba9558"
