import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/all_place_posts_api_response.dart';
import 'package:spott/models/api_responses/all_user_posts_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class AllPostsGetApi{

  Future<AllPlacePostsApiResponse> getAllPlacePosts(
      String _token, String id) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio
          .get(ApiConstants.allPlacePostsApi + id.toString());
      if (response.statusCode == 200) {
        return AllPlacePostsApiResponse.fromJson(response.data);
      } else {
        return AllPlacePostsApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return AllPlacePostsApiResponse.fromJson(e.response?.data);
      } else {
        return AllPlacePostsApiResponse(message: e.toString());
      }
    }
  }

}