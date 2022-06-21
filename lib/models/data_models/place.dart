// ignore_for_file: invalid_assignment
// ignore_for_file:argument_type_not_assignable
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/user.dart';

import 'follow.dart';
import 'is_follow_model.dart';

class Place {
  String? _id;
  dynamic _type;
  String? _name;
  dynamic _details;
  dynamic _lat;
  dynamic _lng;
  String? _fullAddress;
  int? _distance;
  String? _country;
  String? _city;
  dynamic _postalCode;
  String? _streetAddress;
  dynamic _building;
  dynamic _readyDate;
  int? _isReturn;
  dynamic _refId;
  dynamic _refType;
  String? _mainPicture;
  String? _coverPicture;
  int? _userId;
  String? _categoryId;
  dynamic _hashtags;
  List<String>? _images;
  String? _updatedAt;
  String? _createdAt;
  dynamic _averageRating;
  int? _followCount;
  int? _spotCount;
  bool? _placeStoryAvailable;
  List<Ratings>? _ratings;
  List<List<Post>>? _groupStories;
  List<Post>? _posts;
  List<Follow>? _followers;
  IsFollowModel? _isFollowModel;

  String? get id => _id;
  dynamic get type => _type;
  String? get name => _name;
  dynamic get details => _details;
  dynamic get lat => _lat;
  dynamic get lng => _lng;
  String? get fullAddress => _fullAddress;
  int? get distance => _distance;
  String? get country => _country;
  String? get city => _city;
  dynamic get postalCode => _postalCode;
  String? get streetAddress => _streetAddress;
  dynamic get building => _building;
  dynamic get readyDate => _readyDate;
  int? get isReturn => _isReturn;
  dynamic get refId => _refId;
  dynamic get refType => _refType;
  String? get mainPicture => _mainPicture;
  String? get coverPicture => _coverPicture;
  int? get userId => _userId;
  String? get categoryId => _categoryId;
  dynamic get hashtags => _hashtags;
  List<String>? get images => _images;
  String? get updated => _updatedAt;
  String? get createdAT => _createdAt;
  dynamic get averageRating => _averageRating;
  int? get followCount => _followCount;
  int? get spotCount => _spotCount;
  bool? get placeStoryAvailable => _placeStoryAvailable;
  List<Ratings>? get ratings => _ratings;
  List<List<Post>>? get groupStories => _groupStories;
  List<Post>? get posts => _posts;
  List<Follow>? get followers => _followers;
  IsFollowModel? get isFollow => _isFollowModel;
  Place(
      {String? id,
      dynamic type,
      String? name,
      dynamic details,
      dynamic lat,
      dynamic lng,
      String? fullAddress,
      int? distance,
      String? country,
      String? city,
      dynamic postalCode,
      String? streetAddress,
      dynamic building,
      dynamic readyDate,
      int? isReturn,
      dynamic refId,
      dynamic refType,
      String? mainPicture,
      String? coverPicture,
      int? userId,
      String? categoryId,
      dynamic hashtags,
      List<String>? images,
      String? updatedAt,
      String? createdAt,
      dynamic averageRating,
      int? followCount,
      int? spotCount,
        bool? placeStoryAvailable,
      List<Ratings>? ratings,
      List<List<Post>>? groupStories,
      List<Post>? posts,
      IsFollowModel? isFollowModel,
      List<Follow>? followers}) {
    _id = id;
    _type = type;
    _name = name;
    _details = details;
    _lat = lat;
    _lng = lng;
    _fullAddress = fullAddress;
    _distance = distance;
    _country = country;
    _city = city;
    _postalCode = postalCode;
    _streetAddress = streetAddress;
    _building = building;
    _readyDate = readyDate;
    _isReturn = isReturn;
    _refId = refId;
    _refType = refType;
    _mainPicture = mainPicture;
    _coverPicture = coverPicture;
    _userId = userId;
    _categoryId = categoryId;
    _hashtags = hashtags;
    _images = images;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _averageRating = averageRating;
    _followCount = followCount;
    _spotCount = spotCount;
    _placeStoryAvailable = placeStoryAvailable;
    _ratings = ratings;
    _groupStories = groupStories;
    _posts = posts;
    _followers = followers;
    _isFollowModel = isFollowModel;
  }

  Place.fromJson(dynamic json) {
    if (json != null) {
      _id = json["id"]?.toString();
      _type = json["type"];
      _name = json["name"];
      _details = json["details"];
      _lat = ((json as Map).containsKey('lat'))
          ? ((json["lat"] is String)
              ? double.parse(json['lat'])
              : json["lat"]?.toDouble())
          : null;
      _lng = (json.containsKey('lng'))
          ? ((json["lng"] is String)
              ? double.parse(json['lng'])
              : json["lat"]?.toDouble())
          : null;
      _fullAddress = json["fullAddress"];
      _distance = (json["distance"] is int)
          ? json["distance"]
          : json["distance"] != null
              ? int.tryParse(json["distance"].toString())
              : null;
      _country = json["country"];
      _city = json["city"];
      _postalCode = json["postalCode"];
      _streetAddress = json["streetAddress"];
      _building = json["building"];
      _readyDate = json["readyDate"];
      _isReturn = json["isReturn"];
      _refId = json["ref_id"];
      _refType = json["ref_type"];
      _mainPicture = json["main_picture"];
      _coverPicture = json["cover_picture"];
      _userId = json["user_id"];
      _categoryId = json["category_id"]?.toString();
      _hashtags = json["hashtags"];
      if (json["images"] != null) {
        _images = [];
        json["images"].forEach((value) {
          _images!.add(value);
        });
      }
      _updatedAt = json['updated_at'];
      _createdAt = json['created_at'];
      _averageRating = json["average-rating"] != null
          ? double.parse(json["average-rating"].toString())
          : null;
      _followCount = json["follow-count"];
      _spotCount = json["spots_count"];
      _placeStoryAvailable = json['place_story_available'];
      if (json["ratings"] != null) {
        _ratings = [];
        json["ratings"].forEach((v) {
          _ratings?.add(Ratings.fromJson(v));
        });
      }
      if (json['group_stories'] != null) {
        _groupStories = [];
        List<Post> listOfStories = [];
        json['group_stories'].forEach((v) {
          for (int i = 0; i < v.length; i++) {
            listOfStories.add(Post.fromJson(v[i]));
          }

          _groupStories?.add(listOfStories);
          listOfStories = [];
        });
      }

      if (json["posts"] != null) {
        _posts = [];
        json["posts"].forEach((v) {
          _posts?.add(Post.fromJson(v));
        });
      }
      if (json["followers"] != null) {
        _followers = [];
        json["followers"].forEach((v) {
          _followers?.add(Follow.fromJson(v));
        });
      }

      if (json['is_follower'] != null) {
        _isFollowModel = null;
        _isFollowModel = json['is_follower'] != null
            ? IsFollowModel.fromJson(json['is_follower'])
            : null;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = _id;
    map["type"] = _type;
    map["name"] = _name;
    map["details"] = _details;
    map["lat"] = _lat;
    map['lng'] = _lng;
    map["fullAddress"] = _fullAddress;
    map["distance"] = _distance;
    map["country"] = _country;
    map["city"] = _city;
    map["postalCode"] = _postalCode;
    map["streetAddress"] = _streetAddress;
    map["building"] = _building;
    map["readyDate"] = _readyDate;
    map["isReturn"] = _isReturn;
    map["ref_id"] = _refId;
    map["ref_type"] = _refType;
    map["main_picture"] = _mainPicture;
    map["cover_picture"] = _coverPicture;
    map["user_id"] = _userId;
    map["category_id"] = _categoryId;
    map["hashtags"] = _hashtags;
    map['updated_at'] = _updatedAt;
    map["images"] = _images;
    map['created_at'] = _createdAt;
    map["average-rating"] = _averageRating;
    map["follow-count"] = _followCount;
    map["spot-count"] = _spotCount;
    map['place_story_available'] = _placeStoryAvailable;
    map["ratings"] = _ratings;
    map["followers"] = _followers;
    return map;
  }
}

class Ratings {
  int? _id;
  int? _userId;
  int? _placeId;
  dynamic _rating;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get userId => _userId;
  int? get placeId => _placeId;
  dynamic get rating => _rating;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Ratings(
      {int? id,
      int? userId,
      int? placeId,
      dynamic rating,
      String? comment,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _userId = userId;
    _placeId = placeId;
    _rating = rating;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Ratings.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _placeId = json["place_id"];
    _rating = json["rating"];
    _comment = json["comment"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }
}

class GroupStories {
  GroupStories({
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

  GroupStories.fromJson(dynamic json) {
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
