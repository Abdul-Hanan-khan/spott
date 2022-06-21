// ignore_for_file: invalid_assignment

import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/place.dart';

class GetPlaceDetailApiResponse extends GeneralApiResponse {
  Place? _place;

  Place? get place => _place;

  GetPlaceDetailApiResponse({String? message, int? status, Place? place})
      : super(status: status, message: message) {
    _place = place;
  }

  GetPlaceDetailApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _place = json["place"] != null ? Place.fromJson(json["place"]) : null;
    }
  }
}
