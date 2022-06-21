import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/spotted_posts_api_response.dart';
import 'package:spott/models/data_models/place_spotted_list_model.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/utils/constants/api_constants.dart';

class PostSpottedListViewApi {
  Future<SpottedPostsApiResponse> getSpottedListView(String placeId) async {
    try {
      final Map<String, String> headers = {
        "Authorization": "Bearer ${AppData.accessToken}",
        'Language':GetStorage().read('Language')??'en'
      };

      final response = await http.post(
        Uri.parse(ApiConstants.spottedPostApi),
        body: {'place_id': placeId},
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("Spotted listView api => ${response.statusCode}");
        print("Spotted listView api => ${SpottedPostsApiResponse.fromJson(json.decode(response.body)).data?.length}");
        return SpottedPostsApiResponse.fromJson(json.decode(response.body));
      } else {
        return SpottedPostsApiResponse(
            message: SpottedPostsApiResponse.fromJson(json.decode(response.body))
                .message);
      }
    } catch (e) {
      print(e.toString());

      return SpottedPostsApiResponse(message: e.toString());
    }
  }
}
