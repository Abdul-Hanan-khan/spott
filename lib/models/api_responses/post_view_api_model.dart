import 'package:spott/models/data_models/place.dart';

import 'all_rating_api_response_model.dart';

/// status : 1
/// message : "success"
/// data : {"id":48,"user_id":3,"type":"text","content":"Lahore city","lat":31.5073989,"lng":74.2780662,"address":"address","place_id":"30","place_type":"foursquare","status":1,"privacy":"all","media":null,"views":2,"created_at":"2021-11-26T07:45:55.000000Z","updated_at":"2021-11-27T11:27:13.000000Z","reacts_count":1,"comments_count":1,"user_comment_count":0,"spots_count":0,"my_post":false,"user":{"id":3,"name":null,"username":"kashif","email":"kashifhafeez033@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":null,"lng":null,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-13T06:38:05.000000Z","updated_at":"2021-09-13T06:38:05.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":1,"following_count":0,"spots_count":3,"places_count":7,"is_follower":null},"spot":null,"place":{"id":30,"ref_id":"4dcabfd8e4cde9e42f8dc74e","ref_type":"foursquare","name":"Nishtar Block, Allama Iqbal Town","hashtags":null,"details":null,"lat":31.50707402846829,"lng":31.50707402846829,"fullAddress":"لاہور, PK","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"26, Nov 2021 07:45 AM","updated_at":"2021-11-26T07:45:55.000000Z","is_following_count":0,"reacts_count":0,"average-rating":0,"follow-count":0,"spot-count":0,"is_reacted":null,"reacts":[],"is_follower":null,"followers":[]},"reacts":[{"id":357,"user_id":21,"ref_id":48,"type":"post","react_key":2,"created_at":"2021-11-26T08:27:57.000000Z","updated_at":"2021-11-26T08:27:57.000000Z","user":{"id":21,"name":null,"username":"ehsanellahi61","email":"ehsanellahi61@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":31.5073982,"lng":74.2780687,"email_verified_at":"2021-11-25T08:03:38.000000Z","reset_code":null,"type":"public","social_login":"google","isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":"https://grosre.com/uploads/users/1637831468-21-32.png","cover_picture":"https://grosre.com/uploads/users/1637831296-21-50.png","rights":null,"created_by":null,"created_at":"2021-11-25T08:03:38.000000Z","updated_at":"2021-11-25T09:11:08.000000Z","notification_token":"f51acfce-ddaa-46d4-8ff2-cbd747c6193a","followers_count":1,"following_count":0,"spots_count":0,"places_count":1,"is_follower":null}}],"is_reacted":null}
// ignore_for_file: invalid_assignment

class PostViewApiModel {
  PostViewApiModel({
    int? status,
    String? message,
    PostViewApiData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  PostViewApiModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? PostViewApiData.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  PostViewApiData? _data;

  int? get status => _status;
  String? get message => _message;
  PostViewApiData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// id : 48
/// user_id : 3
/// type : "text"
/// content : "Lahore city"
/// lat : 31.5073989
/// lng : 74.2780662
/// address : "address"
/// place_id : "30"
/// place_type : "foursquare"
/// status : 1
/// privacy : "all"
/// media : null
/// views : 2
/// created_at : "2021-11-26T07:45:55.000000Z"
/// updated_at : "2021-11-27T11:27:13.000000Z"
/// reacts_count : 1
/// comments_count : 1
/// user_comment_count : 0
/// spots_count : 0
/// my_post : false
/// user : {"id":3,"name":null,"username":"kashif","email":"kashifhafeez033@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":null,"lng":null,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-13T06:38:05.000000Z","updated_at":"2021-09-13T06:38:05.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":1,"following_count":0,"spots_count":3,"places_count":7,"is_follower":null}
/// spot : null
/// place : {"id":30,"ref_id":"4dcabfd8e4cde9e42f8dc74e","ref_type":"foursquare","name":"Nishtar Block, Allama Iqbal Town","hashtags":null,"details":null,"lat":31.50707402846829,"lng":31.50707402846829,"fullAddress":"لاہور, PK","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"26, Nov 2021 07:45 AM","updated_at":"2021-11-26T07:45:55.000000Z","is_following_count":0,"reacts_count":0,"average-rating":0,"follow-count":0,"spot-count":0,"is_reacted":null,"reacts":[],"is_follower":null,"followers":[]}
/// reacts : [{"id":357,"user_id":21,"ref_id":48,"type":"post","react_key":2,"created_at":"2021-11-26T08:27:57.000000Z","updated_at":"2021-11-26T08:27:57.000000Z","user":{"id":21,"name":null,"username":"ehsanellahi61","email":"ehsanellahi61@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":31.5073982,"lng":74.2780687,"email_verified_at":"2021-11-25T08:03:38.000000Z","reset_code":null,"type":"public","social_login":"google","isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":"https://grosre.com/uploads/users/1637831468-21-32.png","cover_picture":"https://grosre.com/uploads/users/1637831296-21-50.png","rights":null,"created_by":null,"created_at":"2021-11-25T08:03:38.000000Z","updated_at":"2021-11-25T09:11:08.000000Z","notification_token":"f51acfce-ddaa-46d4-8ff2-cbd747c6193a","followers_count":1,"following_count":0,"spots_count":0,"places_count":1,"is_follower":null}}]
/// is_reacted : null

class PostViewApiData {
  PostViewApiData({
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
    dynamic media,
    int? views,
    String? createdAt,
    String? updatedAt,
    int? reactsCount,
    int? commentsCount,
    int? userCommentCount,
    int? spotsCount,
    bool? myPost,
    User? user,
    dynamic spot,
    Place? place,
    List<Reacts>? reacts,
    dynamic isReacted,
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
    _reactsCount = reactsCount;
    _commentsCount = commentsCount;
    _userCommentCount = userCommentCount;
    _spotsCount = spotsCount;
    _myPost = myPost;
    _user = user;
    _spot = spot;
    _place = place;
    _reacts = reacts;
    _isReacted = isReacted;
  }

  PostViewApiData.fromJson(dynamic json) {
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
    _media = json['media'];
    _views = json['views'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _reactsCount = json['reacts_count'];
    _commentsCount = json['comments_count'];
    _userCommentCount = json['user_comment_count'];
    _spotsCount = json['spots_count'];
    _myPost = json['my_post'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _spot = json['spot'];
    _place = json['place'] != null ? Place.fromJson(json['place']) : null;
    if (json['reacts'] != null) {
      _reacts = [];
      json['reacts'].forEach((v) {
        _reacts?.add(Reacts.fromJson(v));
      });
    }
    _isReacted = json['is_reacted'];
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
  dynamic _media;
  int? _views;
  String? _createdAt;
  String? _updatedAt;
  int? _reactsCount;
  int? _commentsCount;
  int? _userCommentCount;
  int? _spotsCount;
  bool? _myPost;
  User? _user;
  dynamic _spot;
  Place? _place;
  List<Reacts>? _reacts;
  dynamic _isReacted;

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
  dynamic get media => _media;
  int? get views => _views;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get reactsCount => _reactsCount;
  int? get commentsCount => _commentsCount;
  int? get userCommentCount => _userCommentCount;
  int? get spotsCount => _spotsCount;
  bool? get myPost => _myPost;
  User? get user => _user;
  dynamic get spot => _spot;
  Place? get place => _place;
  List<Reacts>? get reacts => _reacts;
  dynamic get isReacted => _isReacted;

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
    map['reacts_count'] = _reactsCount;
    map['comments_count'] = _commentsCount;
    map['user_comment_count'] = _userCommentCount;
    map['spots_count'] = _spotsCount;
    map['my_post'] = _myPost;
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
    map['is_reacted'] = _isReacted;
    return map;
  }
}

/// id : 357
/// user_id : 21
/// ref_id : 48
/// type : "post"
/// react_key : 2
/// created_at : "2021-11-26T08:27:57.000000Z"
/// updated_at : "2021-11-26T08:27:57.000000Z"
/// user : {"id":21,"name":null,"username":"ehsanellahi61","email":"ehsanellahi61@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":31.5073982,"lng":74.2780687,"email_verified_at":"2021-11-25T08:03:38.000000Z","reset_code":null,"type":"public","social_login":"google","isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":"https://grosre.com/uploads/users/1637831468-21-32.png","cover_picture":"https://grosre.com/uploads/users/1637831296-21-50.png","rights":null,"created_by":null,"created_at":"2021-11-25T08:03:38.000000Z","updated_at":"2021-11-25T09:11:08.000000Z","notification_token":"f51acfce-ddaa-46d4-8ff2-cbd747c6193a","followers_count":1,"following_count":0,"spots_count":0,"places_count":1,"is_follower":null}

class Reacts {
  Reacts({
    int? id,
    int? userId,
    int? refId,
    String? type,
    int? reactKey,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) {
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
    _id = json['id'];
    _userId = json['user_id'];
    _refId = json['ref_id'];
    _type = json['type'];
    _reactKey = json['react_key'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? _id;
  int? _userId;
  int? _refId;
  String? _type;
  int? _reactKey;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  int? get id => _id;
  int? get userId => _userId;
  int? get refId => _refId;
  String? get type => _type;
  int? get reactKey => _reactKey;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;

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

/// id : 21
/// name : null
/// username : "ehsanellahi61"
/// email : "ehsanellahi61@gmail.com"
/// phone : null
/// country : null
/// bio : null
/// city : null
/// address : null
/// lat : 31.5073982
/// lng : 74.2780687
/// email_verified_at : "2021-11-25T08:03:38.000000Z"
/// reset_code : null
/// type : "public"
/// social_login : "google"
/// isActive : 0
/// isBlocked : 0
/// expiry_date : null
/// profile_picture : "https://grosre.com/uploads/users/1637831468-21-32.png"
/// cover_picture : "https://grosre.com/uploads/users/1637831296-21-50.png"
/// rights : null
/// created_by : null
/// created_at : "2021-11-25T08:03:38.000000Z"
/// updated_at : "2021-11-25T09:11:08.000000Z"
/// notification_token : "f51acfce-ddaa-46d4-8ff2-cbd747c6193a"
/// followers_count : 1
/// following_count : 0
/// spots_count : 0
/// places_count : 1
/// is_follower : null

class User {
  User({
    int? id,
    dynamic name,
    String? username,
    String? email,
    dynamic phone,
    dynamic country,
    dynamic bio,
    dynamic city,
    dynamic address,
    double? lat,
    double? lng,
    String? emailVerifiedAt,
    dynamic resetCode,
    String? type,
    String? socialLogin,
    int? isActive,
    int? isBlocked,
    dynamic expiryDate,
    String? profilePicture,
    String? coverPicture,
    dynamic rights,
    dynamic createdBy,
    String? createdAt,
    String? updatedAt,
    String? notificationToken,
    int? followersCount,
    int? followingCount,
    int? spotsCount,
    int? placesCount,
    dynamic isFollower,
  }) {
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
    _emailVerifiedAt = emailVerifiedAt;
    _resetCode = resetCode;
    _type = type;
    _socialLogin = socialLogin;
    _isActive = isActive;
    _isBlocked = isBlocked;
    _expiryDate = expiryDate;
    _profilePicture = profilePicture;
    _coverPicture = coverPicture;
    _rights = rights;
    _createdBy = createdBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _notificationToken = notificationToken;
    _followersCount = followersCount;
    _followingCount = followingCount;
    _spotsCount = spotsCount;
    _placesCount = placesCount;
    _isFollower = isFollower;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _username = json['username'];
    _email = json['email'];
    _phone = json['phone'];
    _country = json['country'];
    _bio = json['bio'];
    _city = json['city'];
    _address = json['address'];
    _lat = json['lat'];
    _lng = json['lng'];
    _emailVerifiedAt = json['email_verified_at'];
    _resetCode = json['reset_code'];
    _type = json['type'];
    _socialLogin = json['social_login'];
    _isActive = json['isActive'];
    _isBlocked = json['isBlocked'];
    _expiryDate = json['expiry_date'];
    _profilePicture = json['profile_picture'];
    _coverPicture = json['cover_picture'];
    _rights = json['rights'];
    _createdBy = json['created_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _notificationToken = json['notification_token'];
    _followersCount = json['followers_count'];
    _followingCount = json['following_count'];
    _spotsCount = json['spots_count'];
    _placesCount = json['places_count'];
    _isFollower = json['is_follower'];
  }
  int? _id;
  dynamic _name;
  String? _username;
  String? _email;
  dynamic _phone;
  dynamic _country;
  dynamic _bio;
  dynamic _city;
  dynamic _address;
  double? _lat;
  double? _lng;
  String? _emailVerifiedAt;
  dynamic _resetCode;
  String? _type;
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
  dynamic _isFollower;

  int? get id => _id;
  dynamic get name => _name;
  String? get username => _username;
  String? get email => _email;
  dynamic get phone => _phone;
  dynamic get country => _country;
  dynamic get bio => _bio;
  dynamic get city => _city;
  dynamic get address => _address;
  double? get lat => _lat;
  double? get lng => _lng;
  String? get emailVerifiedAt => _emailVerifiedAt;
  dynamic get resetCode => _resetCode;
  String? get type => _type;
  String? get socialLogin => _socialLogin;
  int? get isActive => _isActive;
  int? get isBlocked => _isBlocked;
  dynamic get expiryDate => _expiryDate;
  String? get profilePicture => _profilePicture;
  String? get coverPicture => _coverPicture;
  dynamic get rights => _rights;
  dynamic get createdBy => _createdBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get notificationToken => _notificationToken;
  int? get followersCount => _followersCount;
  int? get followingCount => _followingCount;
  int? get spotsCount => _spotsCount;
  int? get placesCount => _placesCount;
  dynamic get isFollower => _isFollower;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    map['phone'] = _phone;
    map['country'] = _country;
    map['bio'] = _bio;
    map['city'] = _city;
    map['address'] = _address;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['email_verified_at'] = _emailVerifiedAt;
    map['reset_code'] = _resetCode;
    map['type'] = _type;
    map['social_login'] = _socialLogin;
    map['isActive'] = _isActive;
    map['isBlocked'] = _isBlocked;
    map['expiry_date'] = _expiryDate;
    map['profile_picture'] = _profilePicture;
    map['cover_picture'] = _coverPicture;
    map['rights'] = _rights;
    map['created_by'] = _createdBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['notification_token'] = _notificationToken;
    map['followers_count'] = _followersCount;
    map['following_count'] = _followingCount;
    map['spots_count'] = _spotsCount;
    map['places_count'] = _placesCount;
    map['is_follower'] = _isFollower;
    return map;
  }
}
