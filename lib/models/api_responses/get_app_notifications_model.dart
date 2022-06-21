
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';

import 'get_notification_api_response.dart' as flower;


class GetAppNotificationsModel {
  int? _status;
  List<Notifications>? _notifications;

  int? get status => _status;
  List<Notifications>? get notifications => _notifications;

  GetAppNotificationsModel({
      int? status, 
      List<Notifications>? notifications,}){
    _status = status;
    _notifications = notifications;
}

  GetAppNotificationsModel.fromJson(Map json) {
    if(json['status']  !=null) {
      _status = json['status']   as int;
    }else{
      _status = 0;
    }

    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 56
/// user_id : 1
/// ref_user : {"id":7,"name":"kashif","username":"Ali12","profile_picture":null}
/// status : "unread"
/// content : "sent a spot request"
/// type : "you"
/// model : "spot"
/// ref_model_id : 17
/// created_at : "2021-09-28T11:44:06.000000Z"
/// updated_at : "2021-09-28T11:44:06.000000Z"
/// model_data : {"id":17,"ref_id":1,"type":"post","user_id":7,"status":"accept","created_at":"2021-09-28T11:44:06.000000Z","updated_at":"2021-09-28T12:07:04.000000Z","user":{"id":7,"name":"kashif","username":"Ali12","email":"ali@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":31.5074149,"lng":74.2781251,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-19T02:43:02.000000Z","updated_at":"2021-09-28T11:53:57.000000Z","notification_token":"9cd16a0d-6cb5-4b78-9d80-24bad4164175"},"ref":{"id":1,"user_id":1,"type":"image","content":"This is the first ever post","lat":37.4219758,"lng":-122.0840214,"address":"address","place_id":"1","place_type":"foursquare","status":1,"privacy":"all","media":["https://grosre.com/uploads/img/posts/2021/09/1631099072-cc1fc0f6-43.png"],"views":5,"created_at":"2021-09-08T11:04:32.000000Z","updated_at":"2021-09-28T11:53:53.000000Z","likes_count":2,"dislikes_count":1,"reacts_count":1,"comments_count":4,"user_comment_count":0,"total_count":1,"user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"},"spot":null,"place":{"id":1,"ref_id":"4a5e3250f964a52022be1fe3","ref_type":"foursquare","name":"Googleplex - Patio","hashtags":null,"details":null,"lat":37.42199675152714,"lng":37.42199675152714,"fullAddress":"1600 Amphitheatre Pkwy","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"08, Sep 2021 11:04 AM","updated_at":"2021-09-08T11:04:32.000000Z","is_following_count":1,"reacts_count":0,"average-rating":4.9,"follow-count":1,"spot-count":0,"is_reacted":null,"reacts":[],"followers":[{"id":1,"place_id":1,"user_id":1,"created_at":"2021-09-09T13:16:28.000000Z","updated_at":"2021-09-09T13:16:28.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}]},"reacts":[{"id":3,"user_id":1,"ref_id":1,"type":"post","react_key":0,"created_at":"2021-09-30T10:17:50.000000Z","updated_at":"2021-10-05T12:13:17.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}],"is_reacted":{"id":3,"user_id":1,"ref_id":1,"type":"post","react_key":0,"created_at":"2021-09-30T10:17:50.000000Z","updated_at":"2021-10-05T12:13:17.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}}}

class Notifications {
  int? _id;
  int? _userId;
  Ref_user? _refUser;
  dynamic _status;
  dynamic _content;
  dynamic _type;
  dynamic _model;
  int? _refModelId;
  dynamic _createdAt;
  dynamic _updatedAt;
  Model_data? _modelData;

  int? get id => _id;
  int? get userId => _userId;
  Ref_user? get refUser => _refUser;
  dynamic get status => _status;
  dynamic get content => _content;
  dynamic get type => _type;
  dynamic get model => _model;
  int? get refModelId => _refModelId;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  Model_data? get modelData => _modelData;

  Notifications({
      int? id, 
      int? userId, 
      Ref_user? refUser, 
      dynamic status, 
      dynamic content, 
      dynamic type, 
      dynamic model, 
      int? refModelId, 
      dynamic createdAt, 
      dynamic updatedAt, 
      Model_data? modelData,}){
    _id = id;
    _userId = userId;
    _refUser = refUser;
    _status = status;
    _content = content;
    _type = type;
    _model = model;
    _refModelId = refModelId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _modelData = modelData;
}

  Notifications.fromJson(dynamic json) {
    if(json['id']!=null) {
      _id = json['id'] as int;
    }else{
      _id = 0;
    }
    if(json['user_id'] !=null) {
      _userId = json['user_id']  as int;
    }else{
      _userId = 0;
    }
    _refUser = json['ref_user'] != null ? Ref_user.fromJson(json['ref_user']) : null;
    _status = json['status']  ;
    _content = json['content']  ;
    _type = json['type']  ;
    _model = json['model']  ;

    if(json['ref_model_id']  !=null) {
      _refModelId = json['ref_model_id']   as int;
    }else{
      _refModelId = 0;
    }
    _createdAt = json['created_at']  ;
    _updatedAt = json['updated_at']  ;
    _modelData = json['model_data'] != null ? Model_data.fromJson(json['model_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    if (_refUser != null) {
      map['ref_user'] = _refUser?.toJson();
    }
    map['status'] = _status;
    map['content'] = _content;
    map['type'] = _type;
    map['model'] = _model;
    map['ref_model_id'] = _refModelId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_modelData != null) {
      map['model_data'] = _modelData?.toJson();
    }
    return map;
  }

}

/// id : 17
/// ref_id : 1
/// type : "post"
/// user_id : 7
/// status : "accept"
/// created_at : "2021-09-28T11:44:06.000000Z"
/// updated_at : "2021-09-28T12:07:04.000000Z"
/// user : {"id":7,"name":"kashif","username":"Ali12","email":"ali@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":31.5074149,"lng":74.2781251,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-19T02:43:02.000000Z","updated_at":"2021-09-28T11:53:57.000000Z","notification_token":"9cd16a0d-6cb5-4b78-9d80-24bad4164175"}
/// ref : {"id":1,"user_id":1,"type":"image","content":"This is the first ever post","lat":37.4219758,"lng":-122.0840214,"address":"address","place_id":"1","place_type":"foursquare","status":1,"privacy":"all","media":["https://grosre.com/uploads/img/posts/2021/09/1631099072-cc1fc0f6-43.png"],"views":5,"created_at":"2021-09-08T11:04:32.000000Z","updated_at":"2021-09-28T11:53:53.000000Z","likes_count":2,"dislikes_count":1,"reacts_count":1,"comments_count":4,"user_comment_count":0,"total_count":1,"user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"},"spot":null,"place":{"id":1,"ref_id":"4a5e3250f964a52022be1fe3","ref_type":"foursquare","name":"Googleplex - Patio","hashtags":null,"details":null,"lat":37.42199675152714,"lng":37.42199675152714,"fullAddress":"1600 Amphitheatre Pkwy","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"08, Sep 2021 11:04 AM","updated_at":"2021-09-08T11:04:32.000000Z","is_following_count":1,"reacts_count":0,"average-rating":4.9,"follow-count":1,"spot-count":0,"is_reacted":null,"reacts":[],"followers":[{"id":1,"place_id":1,"user_id":1,"created_at":"2021-09-09T13:16:28.000000Z","updated_at":"2021-09-09T13:16:28.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}]},"reacts":[{"id":3,"user_id":1,"ref_id":1,"type":"post","react_key":0,"created_at":"2021-09-30T10:17:50.000000Z","updated_at":"2021-10-05T12:13:17.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}],"is_reacted":{"id":3,"user_id":1,"ref_id":1,"type":"post","react_key":0,"created_at":"2021-09-30T10:17:50.000000Z","updated_at":"2021-10-05T12:13:17.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}}

class Model_data {
  int? _id;
  int? _refId;
  dynamic _type;
  int? _userId;
  dynamic _status;
  dynamic? _createdAt;
  dynamic _updatedAt;
  User? _user;
  Ref? _ref;

  int? get id => _id;
  int? get refId => _refId;
  dynamic get type => _type;
  int? get userId => _userId;
  dynamic? get status => _status;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  User? get user => _user;
  Ref? get ref => _ref;

  Model_data({
      int? id, 
      int? refId, 
      dynamic type, 
      int? userId, 
      dynamic status, 
      dynamic createdAt, 
      dynamic updatedAt, 
      User? user, 
      Ref? ref,}){
    _id = id;
    _refId = refId;
    _type = type;
    _userId = userId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _ref = ref;
}

  Model_data.fromJson(dynamic json) {

    if(json['id']  !=null) {
      _id = json['id']   as int;
    }else{
      _id = 0;
    }

    if(json['ref_id']  !=null) {
      _refId = json['ref_id']   as int;
    }else{
      _refId = 0;
    }

    _type = json['type']  ;

    if(json['user_id']  !=null) {
      _userId = json['user_id']   as int;
    }else{
      _userId = 0;
    }

    _status = json['status'];
    _createdAt = json['created_at']  ;
    _updatedAt = json['updated_at']  ;
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _ref = json['ref'] != null ? Ref.fromJson(json['ref']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    if (_ref != null) {
      map['ref'] = _ref?.toJson();
    }
    return map;
  }

}

/// id : 1
/// user_id : 1
/// type : "image"
/// content : "This is the first ever post"
/// lat : 37.4219758
/// lng : -122.0840214
/// address : "address"
/// place_id : "1"
/// place_type : "foursquare"
/// status : 1
/// privacy : "all"
/// media : ["https://grosre.com/uploads/img/posts/2021/09/1631099072-cc1fc0f6-43.png"]
/// views : 5
/// created_at : "2021-09-08T11:04:32.000000Z"
/// updated_at : "2021-09-28T11:53:53.000000Z"
/// likes_count : 2
/// dislikes_count : 1
/// reacts_count : 1
/// comments_count : 4
/// user_comment_count : 0
/// total_count : 1
/// user : {"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}
/// spot : null
/// place : {"id":1,"ref_id":"4a5e3250f964a52022be1fe3","ref_type":"foursquare","name":"Googleplex - Patio","hashtags":null,"details":null,"lat":37.42199675152714,"lng":37.42199675152714,"fullAddress":"1600 Amphitheatre Pkwy","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"08, Sep 2021 11:04 AM","updated_at":"2021-09-08T11:04:32.000000Z","is_following_count":1,"reacts_count":0,"average-rating":4.9,"follow-count":1,"spot-count":0,"is_reacted":null,"reacts":[],"followers":[{"id":1,"place_id":1,"user_id":1,"created_at":"2021-09-09T13:16:28.000000Z","updated_at":"2021-09-09T13:16:28.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}]}
/// reacts : [{"id":3,"user_id":1,"ref_id":1,"type":"post","react_key":0,"created_at":"2021-09-30T10:17:50.000000Z","updated_at":"2021-10-05T12:13:17.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}]
/// is_reacted : {"id":3,"user_id":1,"ref_id":1,"type":"post","react_key":0,"created_at":"2021-09-30T10:17:50.000000Z","updated_at":"2021-10-05T12:13:17.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}}

class Ref {
  int? _id;
  int? _userId;
  dynamic _type;
  dynamic _content;
   dynamic? _lat;
   dynamic? _lng;
  dynamic _address;
  dynamic _placeId;
  dynamic _placeType;
  int? _status;
  dynamic _privacy;
  List<String>? _media;
  int? _views;
  dynamic _createdAt;
  dynamic _updatedAt;
  int? _likesCount;
  int? _dislikesCount;
  int? _reactsCount;
  int? _commentsCount;
  int? _userCommentCount;
  int? _totalCount;
  User? _user;
  dynamic? _spot;
  Place? _place;
  List<Reacts>? _reacts;
  Is_reacted? _isReacted;

  int? get id => _id;
  int? get userId => _userId;
  dynamic get type => _type;
  dynamic get content => _content;
   dynamic? get lat => _lat;
   dynamic? get lng => _lng;
  dynamic get address => _address;
  dynamic get placeId => _placeId;
  dynamic get placeType => _placeType;
  int? get status => _status;
  dynamic get privacy => _privacy;
  List<String>? get media => _media;
  int? get views => _views;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  int? get likesCount => _likesCount;
  int? get dislikesCount => _dislikesCount;
  int? get reactsCount => _reactsCount;
  int? get commentsCount => _commentsCount;
  int? get userCommentCount => _userCommentCount;
  int? get totalCount => _totalCount;
  User? get user => _user;
  dynamic? get spot => _spot;
  Place? get place => _place;
  List<Reacts>? get reacts => _reacts;
  Is_reacted? get isReacted => _isReacted;

  Ref({
      int? id, 
      int? userId, 
      dynamic type, 
      dynamic content, 
       dynamic? lat, 
       dynamic? lng, 
      dynamic address, 
      dynamic placeId, 
      dynamic placeType, 
      int? status, 
      dynamic privacy, 
      List<String>? media, 
      int? views, 
      dynamic createdAt, 
      dynamic updatedAt, 
      int? likesCount, 
      int? dislikesCount, 
      int? reactsCount, 
      int? commentsCount, 
      int? userCommentCount, 
      int? totalCount, 
      User? user, 
      dynamic? spot, 
      Place? place, 
      List<Reacts>? reacts, 
      Is_reacted? isReacted,}){
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
    _likesCount = likesCount;
    _dislikesCount = dislikesCount;
    _reactsCount = reactsCount;
    _commentsCount = commentsCount;
    _userCommentCount = userCommentCount;
    _totalCount = totalCount;
    _user = user;
    _spot = spot;
    _place = place;
    _reacts = reacts;
    _isReacted = isReacted;
}

  Ref.fromJson(dynamic json) {
    if(json['id']  !=null) {
      _id = json['id']   as int;
    }else{
      _id = 0;
    }

    if(json['user_id']  !=null) {
      _userId = json['user_id']   as int;
    }else{
      _userId = 0;
    }

    _type = json['type']  ;
    _content = json['content']  ;
    _lat = json['lat']  ;
    _lng = json['lng']  ;
    _address = json['address']  ;
    _placeId = json['place_id']  ;
    _placeType = json['place_type']  ;

    if(json['status']  !=null) {
      _status = json['status']   as int;
    }else{
      _status = 0;
    }

    _privacy = json['privacy']   ;
    if(json['media']!=null){
      _media = json['media'].cast<String>() as List<String>;
    }


    if(json['views']  !=null) {
      _views = json['views']   as int;
    }else{
      _views = 0;
    }

    _createdAt = json['created_at']  ;
    _updatedAt = json['updated_at']  ;

    if(json['likes_count']  !=null) {
      _likesCount = json['likes_count']   as int;
    }else{
      _likesCount = 0;
    }


    if(json['dislikes_count']  !=null) {
      _dislikesCount = json['dislikes_count']   as int;
    }else{
      _dislikesCount = 0;
    }


    if(json['reacts_count']  !=null) {
      _reactsCount = json['reacts_count']   as int;
    }else{
      _reactsCount = 0;
    }

    if(json['comments_count']  !=null) {
      _commentsCount = json['comments_count']   as int;
    }else{
      _commentsCount = 0;
    }


    if(json['user_comment_count']  !=null) {
      _userCommentCount = json['user_comment_count']   as int;
    }else{
      _userCommentCount = 0;
    }

    if(json['total_count']  !=null) {
      _totalCount = json['total_count']   as int;
    }else{
      _totalCount = 0;
    }

    if(json['user']!=null){
      _user = json['user'] != null ? User.fromJson(json['user']) : null;
    }
    _spot = json['spot'];
    _place = json['place'] != null ? Place.fromJson(json['place']) : null;
    if (json['reacts'] != null) {
      _reacts = [];
      json['reacts'].forEach((v) {
        _reacts?.add(Reacts.fromJson(v));
      });
    }
    _isReacted = json['is_reacted'] != null ? Is_reacted.fromJson(json['is_reacted']) : null;
  }

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
    map['likes_count'] = _likesCount;
    map['dislikes_count'] = _dislikesCount;
    map['reacts_count'] = _reactsCount;
    map['comments_count'] = _commentsCount;
    map['user_comment_count'] = _userCommentCount;
    map['total_count'] = _totalCount;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['spot'] = _spot;
    if (_place != null) {
      map['place'] = _place?.toJson();
    }
    if (_reacts != null) {
      map['reacts'] = _reacts?.map((v) => v.toJson()).toList();
    }
    if (_isReacted != null) {
      map['is_reacted'] = _isReacted?.toJson();
    }
    return map;
  }

}

/// id : 3
/// user_id : 1
/// ref_id : 1
/// type : "post"
/// react_key : 0
/// created_at : "2021-09-30T10:17:50.000000Z"
/// updated_at : "2021-10-05T12:13:17.000000Z"
/// user : {"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}

class Is_reacted {
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

  Is_reacted({
      int? id, 
      int? userId, 
      int? refId, 
      dynamic type, 
      int? reactKey, 
      dynamic createdAt, 
      dynamic updatedAt, 
      User? user,}){
    _id = id;
    _userId = userId;
    _refId = refId;
    _type = type;
    _reactKey = reactKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Is_reacted.fromJson(dynamic json) {

    if(json['id']  !=null) {
      _id = json['id']   as int;
    }else{
      _id = 0;
    }

    if(json['user_id']  !=null) {
      _userId = json['user_id']   as int;
    }else{
      _userId = 0;
    }

    if(json['ref_id']  !=null) {
      _refId = json['ref_id']   as int;
    }else{
      _refId = 0;
    }

    if(json['ref_id']  !=null) {
      _refId = json['ref_id']   as int;
    }else{
      _refId = 0;
    }

    _type = json['type']  ;

    if(json['react_key']  !=null) {
      _reactKey = json['react_key']   as int;
    }else{
      _reactKey = 0;
    }

    _createdAt = json['created_at']  ;
    _updatedAt = json['updated_at']  ;
    if(json['user']!=null){
      _user =  User.fromJson(json['user']);
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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


class Reacts {
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

  Reacts({
      int? id, 
      int? userId, 
      int? refId, 
      dynamic type, 
      int? reactKey, 
      dynamic createdAt, 
      dynamic updatedAt, 
      User? user,}){
    _id = id;
    _userId = userId;
    _refId = refId;
    _type = type;
    _reactKey = reactKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
}

  Reacts.fromJson(dynamic json) {

    if(json['id']  !=null) {
      _id = json['id']   as int;
    }else{
      _id = 0;
    }

    if(json['user_id']  !=null) {
      _userId = json['user_id']   as int;
    }else{
      _userId = 0;
    }

    if(json['ref_id']  !=null) {
      _refId = json['ref_id']   as int;
    }else{
      _refId = 0;
    }

    _type = json['type']  ;

    if(json['react_key']  !=null) {
      _reactKey = json['react_key']   as int;
    }else{
      _reactKey = 0;
    }

    _createdAt = json['created_at']  ;
    _updatedAt = json['updated_at']  ;
    if (json['user'] != null) {
      _user = User.fromJson(json['user']);
    }
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
/// place_id : 1
/// user_id : 1
/// created_at : "2021-09-09T13:16:28.000000Z"
/// updated_at : "2021-09-09T13:16:28.000000Z"
/// user : {"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"a8d831f3-0342-491f-9b26-2c6a03252c13"}



/// id : 7
/// name : "kashif"
/// username : "Ali12"
/// profile_picture : null

class Ref_user {
  int? _id;
  dynamic _name;
  dynamic _username;
  dynamic? _profilePicture;

  int? get id => _id;
  dynamic get name => _name;
  dynamic get username => _username;
  dynamic? get profilePicture => _profilePicture;

  Ref_user({
      int? id, 
      dynamic name, 
      dynamic username, 
      dynamic? profilePicture}){
    _id = id;
    _name = name;
    _username = username;
    _profilePicture = profilePicture;
}

  Ref_user.fromJson(dynamic json) {

    if(json['id']  !=null) {
      _id = json['id']   as int;
    }else{
      _id = 0;
    }

    if(json['name']!=null) {
      _name = json['name']  ;
    }
    _username = json['username']  ;
    _profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['profile_picture'] = _profilePicture;
    return map;
  }
}