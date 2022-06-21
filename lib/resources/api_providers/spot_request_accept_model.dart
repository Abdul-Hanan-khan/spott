/// status : 1
/// message : "success"
/// data : {"id":37,"ref_id":1,"type":"post","user_id":10,"status":"accept","created_at":"2021-10-11T18:42:44.000000Z","updated_at":"2021-10-12T06:46:37.000000Z","user":{"id":10,"name":"angelo","username":"vitale89_0G5MQS","email":"vitale89@gmail.com","phone":null,"country":null,"bio":"infor test for 🤣😂😭😆","city":null,"address":null,"lat":40.8190714,"lng":15.229132,"email_verified_at":"2021-10-07T11:04:07.000000Z","reset_code":null,"type":"public","social_login":"google","isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":"https://grosre.com/uploads/uploads/users/2021/10/1633977707-10-12.png","cover_picture":"https://grosre.com/uploads/uploads/users/2021/10/1633977707-10-58.png","rights":null,"created_by":null,"created_at":"2021-10-07T11:04:07.000000Z","updated_at":"2021-10-11T18:41:47.000000Z","notification_token":"86b08425-b615-434a-ba97-c3f535155994","followers_count":0,"following_count":0,"spots_count":0,"places_count":0,"is_follower":null},"story":{"id":1,"user_id":1,"type":"image","content":"content","lat":37.4219758,"lng":-122.0840214,"address":"1600 Amphitheatre Pkwy","place_id":"1","place_type":"foursquare","status":1,"privacy":"all","media":["https://grosre.com/uploads/img/posts/2021/09/1631167454-9e380f84-17.png"],"views":0,"created_at":"2021-09-09T06:04:14.000000Z","updated_at":"2021-09-09T06:04:14.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":4,"following_count":3,"spots_count":0,"places_count":1,"is_follower":null},"spot":null}}

class SpotRequestAcceptModel {
  dynamic _status;
  dynamic _message;
  Data? _data;

  dynamic get status => _status;
  dynamic get message => _message;
  Data? get data => _data;

  SpotRequestAcceptModel({
      dynamic status, 
      dynamic message, 
      Data? data}){
    _status = status;
    _message = message;
    _data = data;
}

  SpotRequestAcceptModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    // _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : 37
/// ref_id : 1
/// type : "post"
/// user_id : 10
/// status : "accept"
/// created_at : "2021-10-11T18:42:44.000000Z"
/// updated_at : "2021-10-12T06:46:37.000000Z"
/// user : {"id":10,"name":"angelo","username":"vitale89_0G5MQS","email":"vitale89@gmail.com","phone":null,"country":null,"bio":"infor test for 🤣😂😭😆","city":null,"address":null,"lat":40.8190714,"lng":15.229132,"email_verified_at":"2021-10-07T11:04:07.000000Z","reset_code":null,"type":"public","social_login":"google","isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":"https://grosre.com/uploads/uploads/users/2021/10/1633977707-10-12.png","cover_picture":"https://grosre.com/uploads/uploads/users/2021/10/1633977707-10-58.png","rights":null,"created_by":null,"created_at":"2021-10-07T11:04:07.000000Z","updated_at":"2021-10-11T18:41:47.000000Z","notification_token":"86b08425-b615-434a-ba97-c3f535155994","followers_count":0,"following_count":0,"spots_count":0,"places_count":0,"is_follower":null}
/// story : {"id":1,"user_id":1,"type":"image","content":"content","lat":37.4219758,"lng":-122.0840214,"address":"1600 Amphitheatre Pkwy","place_id":"1","place_type":"foursquare","status":1,"privacy":"all","media":["https://grosre.com/uploads/img/posts/2021/09/1631167454-9e380f84-17.png"],"views":0,"created_at":"2021-09-09T06:04:14.000000Z","updated_at":"2021-09-09T06:04:14.000000Z","user":{"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":4,"following_count":3,"spots_count":0,"places_count":1,"is_follower":null},"spot":null}

class Data {
  dynamic _id;
  dynamic _refId;
  dynamic _type;
  dynamic _userId;
  dynamic _status;
  dynamic _createdAt;
  dynamic _updatedAt;
  User? _user;
  Story? _story;

  dynamic get id => _id;
  dynamic get refId => _refId;
  dynamic get type => _type;
  dynamic get userId => _userId;
  dynamic get status => _status;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  User? get user => _user;
  Story? get story => _story;

  Data({
      dynamic id, 
      dynamic refId, 
      dynamic type, 
      dynamic userId, 
      dynamic status, 
      dynamic createdAt, 
      dynamic updatedAt, 
      User? user, 
      Story? story}){
    _id = id;
    _refId = refId;
    _type = type;
    _userId = userId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _story = story;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _refId = json['ref_id'];
    _type = json['type'];
    _userId = json['user_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    // _user = json['user'] != null ? User.fromJson(json['user']) : null;
    // _story = json['story'] != null ? Story.fromJson(json['story']) : null;
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
    if (_story != null) {
      map['story'] = _story?.toJson();
    }
    return map;
  }

}

/// id : 1
/// user_id : 1
/// type : "image"
/// content : "content"
/// lat : 37.4219758
/// lng : -122.0840214
/// address : "1600 Amphitheatre Pkwy"
/// place_id : "1"
/// place_type : "foursquare"
/// status : 1
/// privacy : "all"
/// media : ["https://grosre.com/uploads/img/posts/2021/09/1631167454-9e380f84-17.png"]
/// views : 0
/// created_at : "2021-09-09T06:04:14.000000Z"
/// updated_at : "2021-09-09T06:04:14.000000Z"
/// user : {"id":1,"name":"Ali","username":"ali","email":"test@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":37.4219758,"lng":-122.0840214,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-08T10:38:59.000000Z","updated_at":"2021-09-08T11:03:48.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":4,"following_count":3,"spots_count":0,"places_count":1,"is_follower":null}
/// spot : null

class Story {
  dynamic _id;
  dynamic _userId;
  dynamic _type;
  dynamic _content;
  dynamic _lat;
  dynamic _lng;
  dynamic _address;
  dynamic _placeId;
  dynamic _placeType;
  dynamic _status;
  dynamic _privacy;
  List<String>? _media;
  dynamic _views;
  dynamic _createdAt;
  dynamic _updatedAt;
  User? _user;
  dynamic? _spot;

  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get type => _type;
  dynamic get content => _content;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  dynamic get address => _address;
  dynamic get placeId => _placeId;
  dynamic get placeType => _placeType;
  dynamic get status => _status;
  dynamic get privacy => _privacy;
  List<String>? get media => _media;
  dynamic get views => _views;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  User? get user => _user;
  dynamic? get spot => _spot;

  Story({
      dynamic id, 
      dynamic userId, 
      dynamic type, 
      dynamic content, 
      dynamic lat, 
      dynamic lng, 
      dynamic address, 
      dynamic placeId, 
      dynamic placeType, 
      dynamic status, 
      dynamic privacy, 
      List<String>? media, 
      dynamic views, 
      dynamic createdAt, 
      dynamic updatedAt, 
      User? user, 
      dynamic? spot}){
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
    _user = user;
    _spot = spot;
}

  Story.fromJson(dynamic json) {
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
    _views = json['views'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _spot = json['spot'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
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
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['spot'] = _spot;
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
/// notification_token : "0bd1f506-f071-4658-9ac1-90a28e8a9155"
/// followers_count : 4
/// following_count : 3
/// spots_count : 0
/// places_count : 1
/// is_follower : null

class User {
  dynamic _id;
  dynamic _name;
  dynamic _username;
  dynamic _email;
  dynamic? _phone;
  dynamic? _country;
  dynamic? _bio;
  dynamic? _city;
  dynamic? _address;
  dynamic _lat;
  dynamic _lng;
  dynamic? _emailVerifiedAt;
  dynamic? _resetCode;
  dynamic _type;
  dynamic? _socialLogin;
  dynamic _isActive;
  dynamic _isBlocked;
  dynamic? _expiryDate;
  dynamic? _profilePicture;
  dynamic? _coverPicture;
  dynamic? _rights;
  dynamic? _createdBy;
  dynamic _createdAt;
  dynamic _updatedAt;
  dynamic _notificationToken;
  dynamic _followersCount;
  dynamic _followingCount;
  dynamic _spotsCount;
  dynamic _placesCount;
  dynamic? _isFollower;

  dynamic get id => _id;
  dynamic get name => _name;
  dynamic get username => _username;
  dynamic get email => _email;
  dynamic? get phone => _phone;
  dynamic? get country => _country;
  dynamic? get bio => _bio;
  dynamic? get city => _city;
  dynamic? get address => _address;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  dynamic? get emailVerifiedAt => _emailVerifiedAt;
  dynamic? get resetCode => _resetCode;
  dynamic get type => _type;
  dynamic? get socialLogin => _socialLogin;
  dynamic get isActive => _isActive;
  dynamic get isBlocked => _isBlocked;
  dynamic? get expiryDate => _expiryDate;
  dynamic? get profilePicture => _profilePicture;
  dynamic? get coverPicture => _coverPicture;
  dynamic? get rights => _rights;
  dynamic? get createdBy => _createdBy;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  dynamic get notificationToken => _notificationToken;
  dynamic get followersCount => _followersCount;
  dynamic get followingCount => _followingCount;
  dynamic get spotsCount => _spotsCount;
  dynamic get placesCount => _placesCount;
  dynamic? get isFollower => _isFollower;

  User({
      dynamic id, 
      dynamic name, 
      dynamic username, 
      dynamic email, 
      dynamic? phone, 
      dynamic? country, 
      dynamic? bio, 
      dynamic? city, 
      dynamic? address, 
      dynamic lat, 
      dynamic lng, 
      dynamic? emailVerifiedAt, 
      dynamic? resetCode, 
      dynamic type, 
      dynamic? socialLogin, 
      dynamic isActive, 
      dynamic isBlocked, 
      dynamic? expiryDate, 
      dynamic? profilePicture, 
      dynamic? coverPicture, 
      dynamic? rights, 
      dynamic? createdBy, 
      dynamic createdAt, 
      dynamic updatedAt, 
      dynamic notificationToken, 
      dynamic followersCount, 
      dynamic followingCount, 
      dynamic spotsCount, 
      dynamic placesCount, 
      dynamic? isFollower}){
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

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
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

/// id : 10
/// name : "angelo"
/// username : "vitale89_0G5MQS"
/// email : "vitale89@gmail.com"
/// phone : null
/// country : null
/// bio : "infor test for 🤣😂😭😆"
/// city : null
/// address : null
/// lat : 40.8190714
/// lng : 15.229132
/// email_verified_at : "2021-10-07T11:04:07.000000Z"
/// reset_code : null
/// type : "public"
/// social_login : "google"
/// isActive : 0
/// isBlocked : 0
/// expiry_date : null
/// profile_picture : "https://grosre.com/uploads/uploads/users/2021/10/1633977707-10-12.png"
/// cover_picture : "https://grosre.com/uploads/uploads/users/2021/10/1633977707-10-58.png"
/// rights : null
/// created_by : null
/// created_at : "2021-10-07T11:04:07.000000Z"
/// updated_at : "2021-10-11T18:41:47.000000Z"
/// notification_token : "86b08425-b615-434a-ba97-c3f535155994"
/// followers_count : 0
/// following_count : 0
/// spots_count : 0
/// places_count : 0
/// is_follower : null

