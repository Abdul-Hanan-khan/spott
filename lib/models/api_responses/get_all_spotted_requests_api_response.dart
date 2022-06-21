import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/spot.dart';

class GetAllSpottedRequestsApiResponse extends GeneralApiResponse {
  List<Spot>? _approvedSpots;
  List<Spot>? _pendingSpots;

  List<Spot>? get approvedSpots => _approvedSpots;
  List<Spot>? get pendingSpots => _pendingSpots;

  GetAllSpottedRequestsApiResponse(
      {int? status,
      String? message,
      List<Spot>? approvedSpots,
      List<Spot>? pendingSpots})
      : super(status: status, message: message) {
    _approvedSpots = approvedSpots;
    _pendingSpots = pendingSpots;
  }

  GetAllSpottedRequestsApiResponse.fromJson(dynamic json)
      : super.fromJson(json) {
    if (json != null) {
      if (json["approved_spots"] != null) {
        _approvedSpots = [];
        json["approved_spots"].forEach((v) {
          _approvedSpots?.add(Spot.fromJson(v));
        });
      }
      if (json["pending_spots"] != null) {
        _pendingSpots = [];
        json["pending_spots"].forEach((v) {
          _pendingSpots?.add(Spot.fromJson(v));
        });
      }
    }
  }
}
