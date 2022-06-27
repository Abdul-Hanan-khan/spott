// ignore_for_file: invalid_assignment
// ignore_for_file:argument_type_not_assignable
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';
import 'spot.dart';

enum PostType { text, image, video }



class Post {
  dynamic _id;
  dynamic _userId;
  PostType? _type;
  String? _content;
  dynamic _lat;
  dynamic _lng;
  dynamic _address;
  dynamic _placeId;
  dynamic _placeType;
  dynamic _status;
  dynamic _privacy;
  List<String>? _media;
  dynamic _views;
  DateTime? _createdAt;
  DateTime? _updatedAt;
  dynamic _commentsCount;
  int? reactsCountt;
  dynamic _spotsCount;
  bool? _myPost;
  bool? seenn;
  dynamic _totaldynamiceractionsCount;
  User? _user;
  Place? _place;
  Spot? _spot;
  List<Reacts>? _reacts;

  Is_reacted? isReactedd;
  bool? isReactRemovedd;
  bool? reactedd;

  dynamic _userCommentCount;

  List<Reacts>? get reacts => _reacts;

  dynamic get id => _id;

  dynamic get userId => _userId;

  PostType? get type => _type;

  String? get content => _content;

  dynamic get lat => _lat;

  dynamic get lng => _lng;

  dynamic get address => _address;

  dynamic get placeId => _placeId;

  dynamic get placeType => _placeType;

  dynamic get status => _status;

  int? get reactsCount => reactsCountt;

  Is_reacted? get isReacted => isReactedd;


  dynamic get isReactRemoved => isReactRemovedd;
  dynamic get reacted => reactedd;




  dynamic get privacy => _privacy;

  List<String>? get media => _media;

  dynamic get views => _views;

  DateTime? get createdAt => _createdAt;

  DateTime? get updatedAt => _updatedAt;

  dynamic get commentsCount => _commentsCount;

  dynamic get spotsCount => _spotsCount;

  bool? get myPost => _myPost;

  bool? get seen => seenn;

  dynamic get totaldynamiceractionsCount => _totaldynamiceractionsCount;

  User? get user => _user;

  Place? get place => _place;

  Spot? get spot => _spot;


  dynamic get userCommentCount => _userCommentCount;


  void postLiked() {
    // if (_isLiked ?? false) {
    //   _isLiked = false;
    //   reactsCountt = (reactsCountt ?? 0) - 1;
    //   _totaldynamiceractionsCount = (_totaldynamiceractionsCount ?? 0) - 1;
    // } else {
    //   if (_isDisliked ?? false) {
    //     _totaldynamiceractionsCount = (_totaldynamiceractionsCount ?? 0) + 1;
    //     _isDisliked = false;
    //     _dislikesCount = (_dislikesCount ?? 0) - 1;
    //   }
    //   _isLiked = true;
    //   reactsCountt = (reactsCountt ?? 0) + 1;
    //   _totaldynamiceractionsCount = (_totaldynamiceractionsCount ?? 0) + 1;
    // }
  }

  void postDisliked() {
    // if (_isDisliked ?? false) {
    //   _isDisliked = false;
    //   _dislikesCount = (_dislikesCount ?? 0) - 1;
    //   _totaldynamiceractionsCount = (_totaldynamiceractionsCount ?? 0) + 1;
    // } else {
    //   if (_isLiked ?? false) {
    //     _totaldynamiceractionsCount = (_totaldynamiceractionsCount ?? 0) - 1;
    //     _isLiked = false;
    //     reactsCountt = (reactsCountt ?? 0) - 1;
    //   }
    //   _isDisliked = true;
    //   _dislikesCount = (_dislikesCount ?? 0) + 1;
    //   _totaldynamiceractionsCount = (_totaldynamiceractionsCount ?? 0) - 1;
    // }
  }

  void updatedCommentCount() {
    if (_commentsCount == null) {
      _commentsCount = 1;
    } else {
      _commentsCount = _commentsCount! + 1;
    }
    if (_userCommentCount == null) {
      _userCommentCount = 1;
    } else {
      _userCommentCount = _userCommentCount! + 1;
    }
  }

  void updateSpotStatus(Spot? _spot) {
    if (_spot != null) {
      this._spot = _spot;
      _spotsCount = (_spotsCount ?? 0) + 1;
    } else {
      this._spot = null;
      _spotsCount = (_spotsCount ?? 1) - 1;
    }
  }

  Post(
      {dynamic id,
      dynamic userId,
      PostType? type,
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
      DateTime? createdAt,
      DateTime? updatedAt,
      dynamic commentsCount,
      dynamic spotsCount,
      bool? myPost,
      dynamic totalDynamicReactionsCount,
      List<Reacts>? reacts,

      Is_reacted? isReacted,

        dynamic isReactRemoved,
        dynamic reacted,

        dynamic reactsCount,
      User? user,
      Place? place,
      Spot? spot,
      bool? seen,
      bool? isSeen,
      dynamic userCommentCount}) {
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
    _commentsCount = commentsCount;
    _spotsCount = spotsCount;
    _totaldynamiceractionsCount = totalDynamicReactionsCount;
    _user = user;
    _place = place;
    reactsCountt = reactsCount;
    _reacts = reacts;
    isReactedd = isReacted;

    isReactRemovedd=isReactRemoved;
    reactedd= reacted;


    _spot = spot;
    seenn = seen;
    _userCommentCount = userCommentCount;
  }

  Post.fromJson(
    dynamic json,
  ) {
    if (json != null) {
      _id = json["id"];
      _userId = json["user_id"];
      _type = PostType.values.firstWhere((e) => e.toString() == 'PostType.${json["type"]}');
      _content = json["content"];
      _lat = json["lat"] as dynamic;
      _lng = json["lng"] as dynamic;
      _address = json["address"];
      _placeId = json["place_id"];
      _placeType = json["place_type"];
      _status = json["status"];
      _privacy = json["privacy"];
      reactsCountt = json['reacts_count'];

      if (json["media"] != null) {
        _media = [];
        json["media"].forEach((value) {
          _media!.add(value);
        });
      }
      if (json['reacts'] != null) {
        _reacts = [];
        json['reacts'].forEach((v) {
          _reacts?.add(Reacts.fromJson(v));
        });
      }

      if (json['is_reacted'] != null) {
        isReactedd = json['is_reacted'] != null ? Is_reacted.fromJson(json['is_reacted']) : null;
      }
      _views = json["views"];
      _createdAt = json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
      _updatedAt = json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
      _commentsCount = json["comments_count"];
      _spotsCount = json['spots_count'];
      _myPost = json['my_post'];
      seenn = json['seen'];
      _totaldynamiceractionsCount = json['total_count'];
      _user = json["user"] != null ? User.fromJson(json["user"]) : null;
      _place = json["place_type"] != null ? Place.fromJson(json["place"]) : null;
      _spot = json['spot'] != null ? Spot.fromJson(json['spot']) : null;
      _userCommentCount = json['user_comment_count'];
    }
  }
}

class Is_reacted {
  dynamic _id;
  dynamic _userId;
  dynamic _refId;
  dynamic _type;
  dynamic reactKeyy;
  dynamic _createdAt;
  dynamic _updatedAt;
  User? _user;

  dynamic get id => _id;

  dynamic get userId => _userId;

  dynamic get refId => _refId;

  dynamic get type => _type;

  dynamic get reactKey => reactKeyy;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  User? get user => _user;

  Is_reacted({
    dynamic id,
    dynamic userId,
    dynamic refId,
    dynamic type,
    dynamic reactKey,
    dynamic createdAt,
    dynamic updatedAt,
    User? user,
  }) {
    _id = id;
    _userId = userId;
    _refId = refId;
    _type = type;
    reactKeyy = reactKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
  }

  Is_reacted.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _refId = json['ref_id'];
    _type = json['type'];
    reactKeyy = json['react_key'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['ref_id'] = _refId;
    map['type'] = _type;
    map['react_key'] = reactKeyy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class Is_liked {
  dynamic _id;
  dynamic _userId;
  dynamic _postId;
  dynamic _type;
  dynamic _createdAt;
  dynamic _updatedAt;

  dynamic get id => _id;

  dynamic get userId => _userId;

  dynamic get postId => _postId;

  dynamic get type => _type;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  Is_liked({dynamic id, dynamic userId, dynamic postId, dynamic type, dynamic createdAt, dynamic updatedAt}) {
    _id = id;
    _userId = userId;
    _postId = postId;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Is_liked.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _postId = json['post_id'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['post_id'] = _postId;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Reacts {
  dynamic _id;
  dynamic _userId;
  dynamic _refId;
  dynamic _type;
  dynamic _reactKey;
  dynamic _createdAt;
  dynamic _updatedAt;
  User? _user;

  dynamic get id => _id;

  dynamic get userId => _userId;

  dynamic get refId => _refId;

  dynamic get type => _type;

  dynamic get reactKey => _reactKey;

  dynamic get createdAt => _createdAt;

  dynamic get updatedAt => _updatedAt;

  User? get user => _user;

  Reacts({dynamic id, dynamic userId, dynamic refId, dynamic type, dynamic reactKey, dynamic createdAt, dynamic updatedAt, User? user}) {
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

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
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
