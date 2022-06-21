import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/spot.dart';

class RequestSpotApiResponse extends GeneralApiResponse {
  Spot? _spot;

  Spot? get spot => _spot;

  RequestSpotApiResponse({int? status, String? message, Spot? spot})
      : super(status: status, message: message) {
    _spot = spot;
  }

  RequestSpotApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _spot = json["data"] != null ? Spot.fromJson(json["data"]) : null;
    }
  }
}
