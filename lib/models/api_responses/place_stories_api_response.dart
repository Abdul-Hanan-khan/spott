class PlaceStoriesApiResponse {
  PlaceStoriesApiResponse({
      String? message, 
      int? status, 
      List<Stories>? stories,}){
    _message = message;
    _status = status;
    _stories = stories;
}

  PlaceStoriesApiResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['stories'] != null) {
      _stories = [];
      json['stories'].forEach((v) {
        _stories?.add(Stories.fromJson(v));
      });
    }
  }
  String? _message;
  int? _status;
  List<Stories>? _stories;

  String? get message => _message;
  int? get status => _status;
  List<Stories>? get stories => _stories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_stories != null) {
      map['stories'] = _stories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Stories {
  Stories({
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
    bool? seen,
    User? user,
    dynamic spot,}){
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
    _seen = seen;
    _user = user;
    _spot = spot;
  }

  Stories.fromJson(dynamic json) {
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
    _seen = json['seen'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _spot = json['spot'];
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
  bool? _seen;
  User? _user;
  dynamic _spot;

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
  bool? get seen => _seen;
  User? get user => _user;
  dynamic get spot => _spot;

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
    map['seen'] = _seen;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['spot'] = _spot;
    return map;
  }

}

class User {
  User({
      int? id, 
      String? name, 
      String? username, 
      String? email, 
      dynamic phone, 
      dynamic country, 
      String? bio, 
      dynamic city, 
      dynamic address, 
      double? lat, 
      double? lng, 
      String? emailVerifiedAt, 
      String? resetCode, 
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
      dynamic isFollower,}){
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
  String? _name;
  String? _username;
  String? _email;
  dynamic _phone;
  dynamic _country;
  String? _bio;
  dynamic _city;
  dynamic _address;
  double? _lat;
  double? _lng;
  String? _emailVerifiedAt;
  String? _resetCode;
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
  String? get name => _name;
  String? get username => _username;
  String? get email => _email;
  dynamic get phone => _phone;
  dynamic get country => _country;
  String? get bio => _bio;
  dynamic get city => _city;
  dynamic get address => _address;
  double? get lat => _lat;
  double? get lng => _lng;
  String? get emailVerifiedAt => _emailVerifiedAt;
  String? get resetCode => _resetCode;
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