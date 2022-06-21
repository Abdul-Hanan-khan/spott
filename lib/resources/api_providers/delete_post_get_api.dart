import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/simple_api_response_model.dart';
import 'package:spott/utils/constants/api_constants.dart';

import '../app_data.dart';

class PostDeleteGetApi {
  Future<SimpleApiResponseModel> deleteGetRequest(int postId) async {
    final http.Response response = await http.get(
        Uri.parse(ApiConstants.baseUrl +
            ApiConstants.deletePostApi +
            postId.toString(),),
        headers: {
          'Authorization': 'Bearer ${AppData.accessToken}',
          'Accept': 'application/json',
          'Language':GetStorage().read('Language')??'en'
        });

    if (response.statusCode == 200) {
      return SimpleApiResponseModel.fromJson(json.decode(response.body));
    } else {
      return SimpleApiResponseModel.fromJson(json.decode(response.body));
    }
  }
}
