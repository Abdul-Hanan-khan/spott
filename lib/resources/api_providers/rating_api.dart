import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/add_rating_response_model.dart';
import 'package:spott/models/api_responses/all_rating_api_response_model.dart';
import 'package:spott/utils/constants/api_constants.dart';

class RatingApi {
  Future<AddRatingResponseModel> addRating(
      String review, String rating, String placeId, String _token) async {
    final finalApi = ApiConstants.baseUrl + ApiConstants.postAddRating;

    Map<String, String> headers = {
      "Authorization": "Bearer $_token",
      'Language': GetStorage().read('Language') ?? 'en'
    };

    final http.Response response = await http.post(
      Uri.parse(finalApi),
      body: {
        'place_id': placeId,
        'comment': review,
        'rating': rating,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return AddRatingResponseModel.fromJson(json.decode(response.body) as Map);
    } else {
      print(response.body);
      return AddRatingResponseModel(
          message:
              AddRatingResponseModel.fromJson(json.decode(response.body) as Map)
                  .message);
    }
  }

  Future<AllRatingApiResponseModel> getAllRating(
      String placeId, String token) async {
    final finalApi = ApiConstants.baseUrl + ApiConstants.postGetAllRating;

    final Map<String, String> headers = {
      "Authorization": "Bearer $token",
      'Language': GetStorage().read('Language') ?? 'en'
    };

    final http.Response response = await http.post(
      Uri.parse(finalApi),
      body: {'place_id': placeId},
      headers: headers,
    );

    if (response.statusCode == 200) {
      print("Get all api response ${response.statusCode}");
      return AllRatingApiResponseModel.fromJson(
          json.decode(response.body) as Map);
    } else {
      print("Get all api response ${response.statusCode}");
      return AllRatingApiResponseModel(
        status: AllRatingApiResponseModel.fromJson(
                json.decode(response.body) as Map)
            .status,
        message: AllRatingApiResponseModel.fromJson(
                json.decode(response.body) as Map)
            .message,
      );
    }
  }
}
