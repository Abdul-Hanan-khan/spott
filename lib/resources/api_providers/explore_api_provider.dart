import 'dart:io';

import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/get_explore_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class ExploreApiProvider {
  Future<GetExploreApiResponse> getExploreData(
      {required String token, required double lat, required double lng}) async {
    try {
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.exploreUrl,
        data: FormData.fromMap(
          {
            'lat': lat,
            'lng': lng,
          },
        ),
      );
      if (response.statusCode == 200) {
        return GetExploreApiResponse.fromJson(response.data);
      } else {
        return GetExploreApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print('Explore screen data error => ${e.toString()}');
        return GetExploreApiResponse.fromJson(e.response?.data);
      } else {
        print('Explore screen data error => ${e.toString()}');

        return GetExploreApiResponse(message: e.toString());
      }
    }
  }
}
