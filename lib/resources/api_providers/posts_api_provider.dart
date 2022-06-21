import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/models/api_responses/add_comment_api_response.dart';
import 'package:spott/models/api_responses/add_post_api_response.dart';
import 'package:spott/models/api_responses/all_posts_pagination_model.dart';
import 'package:spott/models/api_responses/get_all_spotted_requests_api_response.dart';
import 'package:spott/models/api_responses/get_comments_api_response.dart';
import 'package:spott/models/api_responses/get_post_interaction_api_response.dart';
import 'package:spott/models/api_responses/get_posts_api_response.dart';
import 'package:spott/models/api_responses/like_dislike_api_response.dart';
import 'package:spott/models/api_responses/request_spot_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class PostsApiProvider {
  Future<AddPostApiResponse> addNewPost(String token, FormData data) async {
    try {
      final Dio dio = Dio();
      print("Data ${data.fields}");
      dio.options.headers["Authorization"] = "Bearer $token";
      final Response response = await dio
          .post(ApiConstants.baseUrl + ApiConstants.addPostUrl, data: data);
      if (response.statusCode == 200) {
        print("status code ${response.statusCode}");
        debugPrint('add post data ${response.data}');
        return AddPostApiResponse.fromJson(response.data);
      } else {
        return AddPostApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return AddPostApiResponse.fromJson(e.response?.data);
      } else {
        return AddPostApiResponse(message: e.toString());
      }
    }
  }

  Future<AllPostsPaginationModel> getPosts(
      String token, double lat, double long, String? nextPageUrl) async {
    try {
      final finalUrl = nextPageUrl == null
          ? (ApiConstants.baseUrl + ApiConstants.getAllPostsUrl)
          : (ApiConstants.baseUrl +
              ApiConstants.getAllPostsUrl +
              nextPageUrl.replaceAll('/', ''));
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      dio.options.headers["Accept"] = "Application/json";

      Response response = await dio.post(
        finalUrl,
        data: FormData.fromMap(
          {'lat': lat, 'lng': long},
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        return AllPostsPaginationModel.fromJson(response.data);
      } else if (response.statusCode == 204) {
        return AllPostsPaginationModel(
            message: 'Content not available', status: 204);
      } else {
        return AllPostsPaginationModel(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return AllPostsPaginationModel(message: 'Something is wrong');
      } else {
        return AllPostsPaginationModel(message: e.toString());
      }
    }
  }

  Future<LikeDislikeApiResponse> reactPost({
    required String token,
    required String postId,
    required int reactKey,
  }) async {
    print("react post => $reactKey");
    try {
      http.Response response = await http.post(
        Uri.parse(
          ApiConstants.baseUrl + ApiConstants.reactPostApi,
        ),
        body: {
          'post_id': postId,
          'react_key': reactKey.toString(),
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        print('reacts key ${response.statusCode}');
        print('reacts key body ${response.body}');
        return LikeDislikeApiResponse.fromJson(json.decode(response.body));
      } else {
        print(
            'reacts key ${response.statusCode} reacts key msg ${response.body}');
        return LikeDislikeApiResponse(message: response.toString());
      }
    } catch (e) {
      print('reacts key error ${e.toString()}');
      return LikeDislikeApiResponse(message: e.toString());
    }
  }

  Future<LikeDislikeApiResponse> dislikePost({
    required String token,
    required String postId,
  }) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.dislikePostUrl,
        data: FormData.fromMap({'post_id': postId}),
      );
      if (response.statusCode == 200) {
        return LikeDislikeApiResponse.fromJson(response.data);
      } else {
        return LikeDislikeApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return LikeDislikeApiResponse.fromJson(e.response?.data);
      } else {
        return LikeDislikeApiResponse(message: e.toString());
      }
    }
  }

  Future<GetCommentsApiResponse> getAllComments(
      String _token, String _postId) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio
          .get(ApiConstants.baseUrl + ApiConstants.getCommentUrl(_postId));
      if (response.statusCode == 200) {
        return GetCommentsApiResponse.fromJson(response.data);
      } else {
        return GetCommentsApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetCommentsApiResponse.fromJson(e.response?.data);
      } else {
        return GetCommentsApiResponse(message: e.toString());
      }
    }
  }

  Future<AddCommentApiResponse> addComment({
    required String token,
    required String postId,
    required String comment,
  }) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final FormData data = FormData.fromMap(
        {'post_id': postId, 'comment': comment},
      );
      final Response response = await dio
          .post(ApiConstants.baseUrl + ApiConstants.addCommentUrl, data: data);
      if (response.statusCode == 200) {
        return AddCommentApiResponse.fromJson(response.data);
      } else {
        return AddCommentApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return AddCommentApiResponse.fromJson(e.response?.data);
      } else {
        return AddCommentApiResponse(message: e.toString());
      }
    }
  }

  Future<GetPostInteractionApiResponse> getPostInteractions(
    String _token,
    String _postId,
  ) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.get(
          ApiConstants.baseUrl + ApiConstants.getPostInteractionsUrl(_postId));
      if (response.statusCode == 200) {
        return GetPostInteractionApiResponse.fromJson(response.data);
      } else {
        return GetPostInteractionApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetPostInteractionApiResponse.fromJson(e.response?.data);
      } else {
        return GetPostInteractionApiResponse(message: e.toString());
      }
    }
  }

  Future<RequestSpotApiResponse> requestPostSpot(
    String _token,
    String _postId,
  ) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final FormData data = FormData.fromMap(
        {'ref_id': _postId, 'type': 'post'},
      );
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.requestSpottUrl,
          data: data);

      print("Spot response => ${response.data}");
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

  Future<GetAllSpottedRequestsApiResponse> getAllSpottRequests(
    String _token,
    int _postId,
  ) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final FormData data = FormData.fromMap(
        {
          'post_id': _postId,
        },
      );

      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.getAllSpottRequestsUrl,
        data: data,
      );
      if (response.statusCode == 200) {
        return GetAllSpottedRequestsApiResponse.fromJson(response.data);
      } else {
        return GetAllSpottedRequestsApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetAllSpottedRequestsApiResponse.fromJson(e.response?.data);
      } else {
        print("${e.toString()}");
        return GetAllSpottedRequestsApiResponse(message: e.toString());
      }
    }
  }
}
