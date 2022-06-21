import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/get_user_followers_api_response.dart';
import 'package:spott/models/api_responses/get_user_following_api_response.dart';
import 'package:spott/models/api_responses/get_user_spotted_posts_api_response.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class ViewProfileApiProvider {
  Future<ViewProfileApiResponse> viewUserProfile(
      String _token, int _userId) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.get(
        ApiConstants.baseUrl +
            ApiConstants.viewUserProfileUrl +
            _userId.toString(),
      );
      if (response.statusCode == 200) {
        print("Follow data => ${response.data['places']}");
        return ViewProfileApiResponse.fromJson(response.data);
      } else {
        return ViewProfileApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return ViewProfileApiResponse.fromJson(e.response?.data);
      } else {
        return ViewProfileApiResponse(message: e.toString());
      }
    }
  }

  Future<GetUserSpottedPostsApiResponse> getUserSpottedPosts(
      String _token, int _userId) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.userSpottedPostsUrl,
          data: FormData.fromMap({
            'user_id': _userId,
          }));
      if (response.statusCode == 200) {
        return GetUserSpottedPostsApiResponse.fromJson(response.data);
      } else {
        return GetUserSpottedPostsApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print("Spot post error 1 => ${e.response?.data}");
        return GetUserSpottedPostsApiResponse.fromJson(e.response?.data);
      } else {
        print("Spot post error 2 => ${e.toString()}");

        return GetUserSpottedPostsApiResponse(message: e.toString());
      }
    }
  }

  Future<GetUserFollowersApiResponse> getUserFollowers(
      String _token, int _userId) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response =
          await dio.post(ApiConstants.baseUrl + ApiConstants.userFollowersUrl,
              data: FormData.fromMap({
                'user_id': _userId,
              }));
      if (response.statusCode == 200) {
        return GetUserFollowersApiResponse.fromJson(response.data);
      } else {
        return GetUserFollowersApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetUserFollowersApiResponse.fromJson(e.response?.data);
      } else {
        return GetUserFollowersApiResponse(message: e.toString());
      }
    }
  }

  Future<GetUserFollowingApiResponse> getUserFollowing(
      String _token, int _userId) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response =
          await dio.post(ApiConstants.baseUrl + ApiConstants.userFollowingUrl,
              data: FormData.fromMap({
                'user_id': _userId,
              }));
      if (response.statusCode == 200) {
        return GetUserFollowingApiResponse.fromJson(response.data);
      } else {
        return GetUserFollowingApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetUserFollowingApiResponse.fromJson(e.response?.data);
      } else {
        return GetUserFollowingApiResponse(message: e.toString());
      }
    }
  }
}
