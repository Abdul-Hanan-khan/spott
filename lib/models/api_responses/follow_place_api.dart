import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/place_follow_api_model.dart';
import 'package:spott/models/api_responses/place_un_follow_api_model.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/utils/constants/api_constants.dart';

class FollowPlaceApi {
  Future<PlaceFollowApiModel> placeFollowApi(String placeId) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.placeFollowApi),
        headers: {'Authorization': "Bearer ${AppData.accessToken}",
                  "Language":GetStorage().read('language')??'en'},
        body: {
          'place_id': placeId,
        },
      );

      if (response.statusCode == 200) {
        print('place follow => ${response.body}');
        return PlaceFollowApiModel.fromJson(json.decode(response.body));
      } else {

        print('place error follow => ${response.body}');

        return PlaceFollowApiModel(
            message: json.decode(response.body)['message'].toString());
      }
    } catch (e) {
      print('place error follow => ${e.toString()}');
      return PlaceFollowApiModel(message: e.toString());
    }
  }

  Future<PlaceUnFollowApiModel> placeUnFollowApi(String placeId) async {
    try {
      http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.placeUnFollowApi),
        headers: {'Authorization': "Bearer ${AppData.accessToken}",
          "Language":GetStorage().read('language')??'en'},
        body: {
          'place_id': placeId,
        },
      );

      if (response.statusCode == 200) {
        print('place unfollow => ${response.body}');

        return PlaceUnFollowApiModel.fromJson(json.decode(response.body));
      } else {
        print('place unfollow => ${response.body}');


        return PlaceUnFollowApiModel(
          message: json.decode(response.body)['message'].toString(),
        );
      }
    } catch (e) {
      return PlaceUnFollowApiModel(message: e.toString());
    }
  }
}
