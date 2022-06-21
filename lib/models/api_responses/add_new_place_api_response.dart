import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/place.dart';

class AddNewPlaceApiResponse extends GeneralApiResponse {
  Place? _place;

  Place? get place => _place;

  AddNewPlaceApiResponse({int? status, String? message, Place? data})
      : super(status: status, message: message) {
    _place = data;
  }

  AddNewPlaceApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _place = json["data"] != null ? Place.fromJson(json["data"]) : null;
    }
  }
}
