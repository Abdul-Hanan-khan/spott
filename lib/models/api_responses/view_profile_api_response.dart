import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/user.dart';

class ViewProfileApiResponse extends GeneralApiResponse {
  User? _profile;
  List<Post>? _posts;
  List<Place>? _places;

  User? get profile => _profile;

  List<Post>? get posts => _posts;

  List<Place>? get places => _places;

  ViewProfileApiResponse(
      {int? status,
      String? message,
      User? profile,
      List<Post>? posts,
      List<Place>? places})
      : super(status: status, message: message) {
    _profile = profile;
    _posts = posts;
    _places = places;
  }

  ViewProfileApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _profile =
          json["profile"] != null ? User.fromJson(json["profile"]) : null;
      if (json["posts"] != null) {
        _posts = [];
        json["posts"].forEach((v) {
          _posts?.add(Post.fromJson(v));
        });
      }
      if (json["places"] != null) {
        _places = [];
        json["places"].forEach((v) {
          _places?.add(Place.fromJson(v));
        });
      }
    }
  }
}
