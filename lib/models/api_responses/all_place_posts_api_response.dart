import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';

class AllPlacePostsApiResponse {
  AllPlacePostsApiResponse({
    String? message,
    int? status,
    List<Posts>? posts,
  }) {
    _message = message;
    _status = status;
    _posts = posts;
  }

  AllPlacePostsApiResponse.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
    if (json['posts'] != null) {
      _posts = [];
      json['posts'].forEach((v) {
        _posts?.add(Posts.fromJson(v));
      });
    }
  }

  String? _message;
  int? _status;
  List<Posts>? _posts;

  String? get message => _message;

  int? get status => _status;

  List<Posts>? get posts => _posts;
}

class Posts {
  Posts({
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

  Posts.fromJson(dynamic json) {
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
  List<String>? _media;
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

  List<String>? get media => _media;

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
}

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
}

class Followers {
  Followers({
    int? id,
    int? placeId,
    int? userId,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) {
    _id = id;
    _placeId = placeId;
    _userId = userId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
  }

  Followers.fromJson(dynamic json) {
    _id = json['id'];
    _placeId = json['place_id'];
    _userId = json['user_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  int? _id;
  int? _placeId;
  int? _userId;
  String? _createdAt;
  String? _updatedAt;
  User? _user;

  int? get id => _id;

  int? get placeId => _placeId;

  int? get userId => _userId;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  User? get user => _user;
}
