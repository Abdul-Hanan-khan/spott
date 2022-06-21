/// message : "Rating exist already"
/// status : 0
/// rating : {"id":1,"user_id":1,"place_id":6,"rating":4.9,"comment":"Lovely place, will visit again","created_at":"2021-09-25T18:21:54.000000Z","updated_at":"2021-09-25T18:21:54.000000Z"}

class AddRatingResponseModel {
  AddRatingResponseModel({
    dynamic message,
    dynamic status,
    Rating? rating,
  }) {
    _message = message;
    _status = status;
    _rating = rating;
  }

  AddRatingResponseModel.fromJson(Map json) {
    _message = json['message'] as dynamic;
    _status = json['status'] as dynamic;
    _rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  dynamic _message;
  dynamic _status;
  Rating? _rating;

  dynamic get message => _message;
  dynamic get status => _status;
  Rating? get rating => _rating;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_rating != null) {
      map['rating'] = _rating?.toJson();
    }
    return map;
  }
}

/// id : 1
/// user_id : 1
/// place_id : 6
/// rating : 4.9
/// comment : "Lovely place, will visit again"
/// created_at : "2021-09-25T18:21:54.000000Z"
/// updated_at : "2021-09-25T18:21:54.000000Z"

class Rating {
  Rating({
    dynamic id,
    dynamic userId,
    dynamic placeId,
    double? rating,
    dynamic comment,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    _id = id;
    _userId = userId;
    _placeId = placeId;
    _rating = rating;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Rating.fromJson(dynamic json) {
    _id = json['id'] as dynamic;
    _userId = json['user_id'] as dynamic;
    _placeId = json['place_id'] as dynamic;
    _rating = json['rating'] as dynamic;
    _comment = json['comment'] as dynamic;
    _createdAt = json['created_at'] as dynamic;
    _updatedAt = json['updated_at'] as dynamic;
  }
  dynamic _id;
  dynamic _userId;
  dynamic _placeId;
  dynamic _rating;
  dynamic _comment;
  dynamic _createdAt;
  dynamic _updatedAt;

  dynamic get id => _id;
  dynamic get userId => _userId;
  dynamic get placeId => _placeId;
  dynamic get rating => _rating;
  dynamic get comment => _comment;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<dynamic, dynamic> toJson() {
    final map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['place_id'] = _placeId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
