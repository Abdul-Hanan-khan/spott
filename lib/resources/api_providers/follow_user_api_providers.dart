import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:spott/models/api_responses/follow_user_api_response.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

class FollowUserApiProvider {
  Future<FollowUserApiResponse> followUser(
      {required String token,
      required int userId,
      required int followerId}) async {
    try {
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.followUserUrl,
        data: FormData.fromMap(
          {
            'user_id': userId,
            'follower_id': followerId,
          },
        ),
      );
      if (response.statusCode == 200) {
        print('follow => ${response.data}');
        return FollowUserApiResponse.fromJson(response.data);
      } else {
        return FollowUserApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print('follow => ${e.response!.data}');
        return FollowUserApiResponse.fromJson(
            e.response?.data ?? LocaleKeys.failedToFollow.tr());
      } else {
        return FollowUserApiResponse(message: e.toString());
      }
    }
  }

  Future<FollowUserApiResponse> unFollowUser(
      {required String token,
      required int userId,
      required int followerId,}) async {
    try {
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.unFollowUserUrl,
        data: FormData.fromMap(
          {
            'user_id': userId,
            'follower_id': followerId,
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Follow result =>  ${response.data}");
        return FollowUserApiResponse.fromJson(response.data);
      } else {

        return FollowUserApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print("Follow result => ${e.response!.data}");
        return FollowUserApiResponse.fromJson(e.response?.data);
      } else {
        return FollowUserApiResponse(message: e.toString());
      }
    }
  }
}
