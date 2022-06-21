import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/create_story_api_response.dart';
import 'package:spott/models/api_responses/get_posts_api_response.dart';
import 'package:spott/models/api_responses/mark_stories_as_seen_api_response.dart';
import 'package:spott/models/api_responses/request_spot_api_response.dart';
import 'package:spott/models/api_responses/story_post_api_model.dart';
import 'package:spott/utils/constants/api_constants.dart';

import '../../models/api_responses/post_seen_api_response.dart';

class StoriesApiProvider {
  Future<CreateStroyApiResponse> createStory(
      String token, FormData data) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio
          .post(ApiConstants.baseUrl + ApiConstants.createStoryUrl, data: data);
      if (response.statusCode == 200) {
        return CreateStroyApiResponse.fromJson(response.data);
      } else {
        return CreateStroyApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response?.data);
        return CreateStroyApiResponse.fromJson(e.response?.data);
      } else {
        return CreateStroyApiResponse(message: e.toString());
      }
    }
  }

  Future<StoryPostApiModel> getStories(String token, FormData data) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.getAllStoriesUrl,
          data: data);
      print("get stories model => ${response.data}");
      if (response.statusCode == 200) {
        return StoryPostApiModel.fromJson(response.data);
      } else {
        return StoryPostApiModel(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print("Get stories error 1 => ${e.toString()}");
        return StoryPostApiModel.fromJson(e.response?.data);
      } else {
        print("Get stories error  2 => ${e.toString()}");
        return StoryPostApiModel(message: e.toString());
      }
    }
  }

  Future<MarkStoriesAsSeenApiResponse> markStoryAsSeen(
      String token, int storyId) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.markStoryAsReadApiUrl,
          data: FormData.fromMap({'story_id': storyId}));
      if (response.statusCode == 200) {
        return MarkStoriesAsSeenApiResponse.fromJson(response.data);
      } else {
        return MarkStoriesAsSeenApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return MarkStoriesAsSeenApiResponse.fromJson(e.response?.data);
      } else {
        return MarkStoriesAsSeenApiResponse(message: e.toString());
      }
    }
  }
  Future<PostSeenApiResponse> markPostAsSeen(
      String token, int postId) async {

    print("\n\n\nn\n\n");
    print(postId);
    print("\n\n\nn\n\n");

    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      final Response response = await dio.post(ApiConstants.postSeen,
          data: FormData.fromMap({'post_id': postId}));
      print("\n\n\n");
      print(response.data);
      print("\n\n\n");
      if (response.statusCode == 200) {
        return PostSeenApiResponse.fromJson(response.data);
      } else {
        return PostSeenApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return PostSeenApiResponse.fromJson(e.response?.data);
      } else {
        return PostSeenApiResponse(message: e.toString());
      }
    }
  }

  Future<RequestSpotApiResponse> requestStorySpot(
      String _token, String _storyId) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $_token";
      final FormData data = FormData.fromMap(
        {'story_id': _storyId},
      );
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.requestStorySpottUrl,
          data: data);
      if (response.statusCode == 200) {
        return RequestSpotApiResponse.fromJson(response.data);
      } else {
        return RequestSpotApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return RequestSpotApiResponse.fromJson(e.response?.data);
      } else {
        return RequestSpotApiResponse(message: e.toString());
      }
    }
  }
}
