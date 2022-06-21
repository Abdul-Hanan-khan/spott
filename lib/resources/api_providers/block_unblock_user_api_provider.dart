import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/block_user_api_response.dart';
import 'package:spott/models/api_responses/get_blocked_users_api_response.dart';
import 'package:spott/models/api_responses/unblock_user_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class BlockUnBlockUserAPiProvider {
  Future<BlockUserApiResponse> blockUser(String _token, String _userId) async {
    try {
      final dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $_token";
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.blockUserApiUrl,
        data: FormData.fromMap(
          {'user_id': _userId},
        ),
      );
      if (response.statusCode == 200) {
        return BlockUserApiResponse.fromJson(response.data);
      } else {
        return BlockUserApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return BlockUserApiResponse.fromJson(e.response?.data);
      } else {
        return BlockUserApiResponse(message: e.toString());
      }
    }
  }

  Future<GetBlockedUsersApiResponse> getAllBlockedUsers(
    String _token,
  ) async {
    try {
      final dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getBlockedUsersApiUrl,
      );
      if (response.statusCode == 200) {
        return GetBlockedUsersApiResponse.fromJson(response.data);
      } else {
        return GetBlockedUsersApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetBlockedUsersApiResponse.fromJson(e.response?.data);
      } else {
        return GetBlockedUsersApiResponse(message: e.toString());
      }
    }
  }

  Future<UnblockUserApiResponse> unblockUser(
      String _token, String _userId) async {
    try {
      final dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.unblockUserApiUrl,
        data: FormData.fromMap(
          {'user_id': _userId},
        ),
      );
      if (response.statusCode == 200) {
        return UnblockUserApiResponse.fromJson(response.data);
      } else {
        return UnblockUserApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UnblockUserApiResponse.fromJson(e.response?.data);
      } else {
        return UnblockUserApiResponse(message: e.toString());
      }
    }
  }
}
