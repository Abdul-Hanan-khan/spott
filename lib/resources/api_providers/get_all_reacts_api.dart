import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/models/api_responses/post_reacts_model.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/utils/constants/api_constants.dart';

import '../app_data.dart';

class GetPostReact {
  Future<PostReactsModel> getAllReacts(String postId) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.reactsGetApi),
        headers: {
          'Accept': 'Application/json',
          'Authorization': "Bearer ${AppData.accessToken}",
          'Language':GetStorage().read('Language')??'en'
        },
        body: {'post_id': postId},
      );

      if (response.statusCode == 200) {
        return PostReactsModel.fromJson(json.decode(response.body));
      } else {
        print('Error on post 1 => ${response.body}');
        return PostReactsModel(
            status: json.decode(response.body)!['status'] as int);
      }
    } catch (e) {
      print('Error on post  2=> ${e.toString()}');
      return PostReactsModel(status: 0);
    }
  }
}
