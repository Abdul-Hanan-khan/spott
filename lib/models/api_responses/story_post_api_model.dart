import 'package:spott/models/data_models/post.dart';

/// status : 1
/// message : "success"
/// data : [[{"id":38,"user_id":3,"type":"image","content":"content","lat":37.4220084,"lng":-122.0841105,"address":"1600 Amphitheatre Pkwy","place_id":"32","place_type":"foursquare","status":1,"privacy":"all","media":["https://grosre.com/uploads/img/posts/2021/11/1638212731-3vlvjgyiyz-16.png"],"views":0,"created_at":"2021-11-29T19:05:31.000000Z","updated_at":"2021-11-29T19:05:31.000000Z","seen_count":0,"user":{"id":3,"name":null,"username":"kashif","email":"kashifhafeez033@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":null,"lng":null,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-13T06:38:05.000000Z","updated_at":"2021-09-13T06:38:05.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":1,"following_count":0,"spots_count":3,"places_count":7,"is_follower":null},"spot":null,"place":{"id":32,"ref_id":"49e8d0b4f964a52090651fe3","ref_type":"foursquare","name":"Googleplex - 43","hashtags":null,"details":null,"lat":37.421555706101486,"lng":37.421555706101486,"fullAddress":"1600 Amphitheatre Pkwy","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"29, Nov 2021 07:05 PM","updated_at":"2021-11-29T19:05:31.000000Z","is_following_count":0,"reacts_count":0,"average-rating":0,"follow-count":0,"spot-count":0,"is_reacted":null,"reacts":[],"is_follower":null,"followers":[]}},{"id":37,"user_id":3,"type":"image","content":"content","lat":37.4220084,"lng":-122.0841105,"address":"1600 Amphitheatre Parkway","place_id":"31","place_type":"foursquare","status":1,"privacy":"all","media":["https://grosre.com/uploads/img/posts/2021/11/1638212690-muubirvgmu-79.png"],"views":0,"created_at":"2021-11-29T19:04:50.000000Z","updated_at":"2021-11-29T19:04:50.000000Z","seen_count":0,"user":{"id":3,"name":null,"username":"kashif","email":"kashifhafeez033@gmail.com","phone":null,"country":null,"bio":null,"city":null,"address":null,"lat":null,"lng":null,"email_verified_at":null,"reset_code":null,"type":"public","social_login":null,"isActive":0,"isBlocked":0,"expiry_date":null,"profile_picture":null,"cover_picture":null,"rights":null,"created_by":null,"created_at":"2021-09-13T06:38:05.000000Z","updated_at":"2021-09-13T06:38:05.000000Z","notification_token":"0bd1f506-f071-4658-9ac1-90a28e8a9155","followers_count":1,"following_count":0,"spots_count":3,"places_count":7,"is_follower":null},"spot":null,"place":{"id":31,"ref_id":"40870b00f964a5209bf21ee3","ref_type":"foursquare","name":"Googleplex","hashtags":null,"details":null,"lat":37.4223098,"lng":37.4223098,"fullAddress":"1600 Amphitheatre Parkway","images":null,"main_picture":null,"cover_picture":null,"user_id":null,"category_id":4,"created_at":"29, Nov 2021 07:04 PM","updated_at":"2021-11-29T19:04:50.000000Z","is_following_count":0,"reacts_count":0,"average-rating":0,"follow-count":0,"spot-count":0,"is_reacted":null,"reacts":[],"is_follower":null,"followers":[]}}]]
// ignore_for_file: invalid_assignment

class StoryPostApiModel {
  StoryPostApiModel({
    int? status,
    String? message,
    List<List<Post>>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  StoryPostApiModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      List<Post> list = [];

      json['data'].forEach((v) {
        for (int i = 0; i < int.parse(v.length.toString()); i++) {
          list.add(Post.fromJson(v[i]));
        }
        _data!.add(list);
        list = [];
      });
    }
  }
  int? _status;
  String? _message;
  List<List<Post>>? _data;

  int? get status => _status;
  String? get message => _message;
  List<List<Post>>? get data => _data;
}
