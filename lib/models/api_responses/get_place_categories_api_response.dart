import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/place_category.dart';

class GetPlaceCategoriesApiResponse extends GeneralApiResponse {
  List<PlaceCategory>? _categories;

  List<PlaceCategory>? get categories => _categories;

  GetPlaceCategoriesApiResponse(
      {int? status, String? message, List<PlaceCategory>? data})
      : super(status: status, message: message) {
    _categories = data;
  }

  GetPlaceCategoriesApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null && json["data"] != null) {
      _categories = [];
      json["data"].forEach((v) {
        _categories?.add(PlaceCategory.fromJson(v));
      });
    }
  }
}
