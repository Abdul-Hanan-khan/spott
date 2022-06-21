import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/user_all_story_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class UserStoryPostsGetApi{

  Future<UserAllStoryApiResponse> getAllUserPosts(
      String _token, String id) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.get(ApiConstants.userStoryPostsApi + id.toString());

      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200) {
        return UserAllStoryApiResponse.fromJson(response.data);
      } else {
        return UserAllStoryApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UserAllStoryApiResponse.fromJson(e.response?.data);
      } else {
        return UserAllStoryApiResponse(message: e.toString());
      }
    }
  }

}