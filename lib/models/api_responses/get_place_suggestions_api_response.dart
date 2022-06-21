import 'package:spott/models/data_models/place.dart';
import 'general_api_response.dart';

class GetPlaceSuggestionsApiResponse extends GeneralApiResponse {
  List<Place>? _places;

  List<Place>? get places => _places;

  GetPlaceSuggestionsApiResponse(
      {int? status, String? message, List<Place>? data})
      : super(status: status, message: message) {
    _places = data;
  }

  GetPlaceSuggestionsApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json!=null && json["data"] != null) {
      _places = [];
      json["data"].forEach((v) {
        _places?.add(Place.fromJson(v));
      });
    }
  }
}
