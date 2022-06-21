import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/top_sports_pagination_model.dart';
import 'package:spott/utils/constants/api_constants.dart';

class TopSpotsApi {
  Future<TopSportsPaginationModel> getTopSpotsData(
      {required String token,
      required double lat,
      required double lng,
      String? nextPageUrlPlaces}) async {
    print("Bearer token => ${token}");
    try {
      final finalUrl = nextPageUrlPlaces == null
          ? ApiConstants.baseUrl + ApiConstants.topSportsApi
          : ApiConstants.baseUrl +
              ApiConstants.topSportsApi +
              nextPageUrlPlaces.replaceAll('/', '');
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        finalUrl,
        data: FormData.fromMap(
          {
            'lat': lat,
            'lng': lng,
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Response top sports => ${response.data}");
        return TopSportsPaginationModel.fromJson(response.data);
      } else {
        return TopSportsPaginationModel(status: 0);
      }
    } catch (e) {
      if (e is DioError) {
        print('Explore screen data error 1 => ${e.toString()}');
        print('Explore screen data error 1 => ${e.response?.data}');
        return TopSportsPaginationModel.fromJson(e.response?.data);
      } else {
        print('Explore screen data error => ${e.toString()}');

        return TopSportsPaginationModel(status: 0);
      }
    }
  }
}
