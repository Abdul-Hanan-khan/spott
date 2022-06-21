import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/post.dart';

class GetExploreApiResponse extends GeneralApiResponse {
  List<Post>? _topSpots;
  List<Place>? _topPlaces;

  List<Post>? get topSpots => _topSpots;
  List<Place>? get topPlaces => _topPlaces;

  GetExploreApiResponse(
      {int? status,
      String? message,
      List<Post>? topSpots,
      List<Place>? topPlaces})
      : super(status: status, message: message) {
    _topSpots = topSpots;
    _topPlaces = topPlaces;
  }

  GetExploreApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      if (json["top_spots"] != null) {
        _topSpots = [];
        json["top_spots"].forEach((v) {
          _topSpots?.add(Post.fromJson(v));
        });
      }
      if (json["top_places"] != null) {
        _topPlaces = [];
        json["top_places"].forEach((v) {
          _topPlaces?.add(Place.fromJson(v));
        });
      }
    }
  }
}
