import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/get_share_able_link_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class ShareAbleLinksApiProvider {
  Future<GetShareAbleLinkApiResponse> getUserProfileLink(
      String _token, int _userId) async {
    try {
      final dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.getUserProfileShareLink,
        data: FormData.fromMap(
          {'user_id': _userId},
        ),
      );
      if (response.statusCode == 200) {
        return GetShareAbleLinkApiResponse.fromJson(response.data);
      } else {
        return GetShareAbleLinkApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetShareAbleLinkApiResponse.fromJson(e.response?.data);
      } else {
        return GetShareAbleLinkApiResponse(message: e.toString());
      }
    }
  }

  Future<GetShareAbleLinkApiResponse> getPlaceShareAbleLink(
      String _token, String _placeId) async {
    try {
      final dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.getPlaceProfileShareLink,
        data: FormData.fromMap(
          {'place_id': _placeId},
        ),
      );
      if (response.statusCode == 200) {
        return GetShareAbleLinkApiResponse.fromJson(response.data);
      } else {
        return GetShareAbleLinkApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetShareAbleLinkApiResponse.fromJson(e.response?.data);
      } else {
        return GetShareAbleLinkApiResponse(message: e.toString());
      }
    }
  }
}
