/// message : "success"
/// status : 1
/// ratings : [{"id":2,"user_id":1,"place_id":6,"rating":4.9,"comment":"good place","created_at":"2021-09-25T19:28:19.000000Z","updated_at":"2021-09-25T19:28:19.000000Z","place":{"id":6,"ref_id":"4f5220e5e4b063296ca1d804","ref_type":"foursquare","name":"Gourmet Bakery","hashtags":null,"details":null,"lat":31.541416164479013,"lng":31.541416164479013,"fullAddress":"420 A Block, Gulshan-e-Ravi","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"19, Sep 2021 02:46 AM","updated_at":"2021-09-19T02:46:33.000000Z","is_following_count":0,"average-rating":4.7,"follow-count":0,"spot-count":0,"followers":[]}},{"id":4,"user_id":7,"place_id":6,"rating":4.5,"comment":"good","created_at":"2021-09-27T11:01:53.000000Z","updated_at":"2021-09-27T11:01:53.000000Z","place":{"id":6,"ref_id":"4f5220e5e4b063296ca1d804","ref_type":"foursquare","name":"Gourmet Bakery","hashtags":null,"details":null,"lat":31.541416164479013,"lng":31.541416164479013,"fullAddress":"420 A Block, Gulshan-e-Ravi","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"19, Sep 2021 02:46 AM","updated_at":"2021-09-19T02:46:33.000000Z","is_following_count":0,"average-rating":4.7,"follow-count":0,"spot-count":0,"followers":[]}}]
import 'package:spott/models/data_models/place.dart';

class AllRatingApiResponseModel {
  dynamic? _message;
  dynamic? _status;
  List<Ratings>? _ratings;

  dynamic? get message => _message;
  dynamic? get status => _status;
  List<Ratings>? get ratings => _ratings;

  AllRatingApiResponseModel({
      dynamic? message,
      dynamic? status,
      List<Ratings>? ratings}){
    _message = message;
    _status = status;
    _ratings = ratings;
}

  AllRatingApiResponseModel.fromJson(Map json) {
    _message = json['message'] as dynamic;
    _status = json['status']  as dynamic;
    if (json['ratings'] != null) {
      _ratings = [];
      json['ratings'].forEach((v) {
        _ratings?.add(Ratings.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    if (_ratings != null) {
      map['ratings'] = _ratings?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 2
/// user_id : 1
/// place_id : 6
/// rating : 4.9
/// comment : "good place"
/// created_at : "2021-09-25T19:28:19.000000Z"
/// updated_at : "2021-09-25T19:28:19.000000Z"
/// place : {"id":6,"ref_id":"4f5220e5e4b063296ca1d804","ref_type":"foursquare","name":"Gourmet Bakery","hashtags":null,"details":null,"lat":31.541416164479013,"lng":31.541416164479013,"fullAddress":"420 A Block, Gulshan-e-Ravi","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"19, Sep 2021 02:46 AM","updated_at":"2021-09-19T02:46:33.000000Z","is_following_count":0,"average-rating":4.7,"follow-count":0,"spot-count":0,"followers":[]}

class Ratings {
  dynamic? _id;
  dynamic? _userId;
  dynamic? _placeId;
  dynamic _rating;
  dynamic? _comment;
  dynamic? _createdAt;
  dynamic? _updatedAt;
  Place? _place;

  dynamic? get id => _id;
  dynamic? get userId => _userId;
  dynamic? get placeId => _placeId;
  dynamic get rating => _rating;
  dynamic? get comment => _comment;
  dynamic? get createdAt => _createdAt;
  dynamic? get updatedAt => _updatedAt;
  Place? get place => _place;

  Ratings({
      dynamic? id,
      dynamic? userId,
      dynamic? placeId,
      dynamic rating,
      dynamic? comment,
      dynamic? createdAt,
      dynamic? updatedAt,
      Place? place}){
    _id = id;
    _userId = userId;
    _placeId = placeId;
    _rating = rating;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _place = place;
}

  Ratings.fromJson(dynamic json) {
    _id = json['id'] as dynamic;
    _userId = json['user_id'] as dynamic;
    _placeId = json['place_id'] as dynamic;
    _rating = json['rating'] as dynamic;
    _comment = json['comment'] as dynamic;
    _createdAt = json['created_at'] as dynamic;
    _updatedAt = json['updated_at'] as dynamic;
    _place = json['place'] != null ? Place.fromJson(json['place']) : null;
  }

  Map<dynamic, dynamic> toJson() {
    var map = <dynamic, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['place_id'] = _placeId;
    map['rating'] = _rating;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_place != null) {
      map['place'] = _place?.toJson();
    }
    return map;
  }

}

/// id : 6
/// ref_id : "4f5220e5e4b063296ca1d804"
/// ref_type : "foursquare"
/// name : "Gourmet Bakery"
/// hashtags : null
/// details : null
/// lat : 31.541416164479013
/// lng : 31.541416164479013
/// fullAddress : "420 A Block, Gulshan-e-Ravi"
/// images : null
/// main_picture : null
/// cover_picture : null
/// user_id : null
/// category_id : 4
/// created_at : "19, Sep 2021 02:46 AM"
/// updated_at : "2021-09-19T02:46:33.000000Z"
/// is_following_count : 0
/// average-rating : 4.7
/// follow-count : 0
/// spot-count : 0
/// followers : []
