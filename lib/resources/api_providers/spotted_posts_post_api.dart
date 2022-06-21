import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/spotted_posts_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class SpottedPostsPostApi{


  Future<SpottedPostsApiResponse> spottedPosts(
      {required String token,
        required String postId}) async {
    try {
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(ApiConstants.spottedPostApi,
        data: FormData.fromMap(
          {
            'place_id': postId,
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Follow result =>  ${response.data}");
        return SpottedPostsApiResponse.fromJson(response.data);
      } else {

        return SpottedPostsApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print("Follow result => ${e.response!.data}");
        return SpottedPostsApiResponse.fromJson(e.response?.data);
      } else {
        return SpottedPostsApiResponse(message: e.toString());
      }
    }
  }

}