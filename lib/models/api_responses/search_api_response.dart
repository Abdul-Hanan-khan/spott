import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/user.dart';

class SearchApiResponse extends GeneralApiResponse {
  List<User>? _users;
  List<Place>? _places;

  List<User>? get users => _users;
  List<Place>? get places => _places;

  SearchApiResponse(
      {int? status, String? message, List<User>? users, List<Place>? places})
      : super(status: status, message: message) {
    _users = users;
    _places = places;
  }

  SearchApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      if (json["users"] != null) {
        _users = [];
        json["users"].forEach((v) {
          _users?.add(User.fromJson(v));
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
