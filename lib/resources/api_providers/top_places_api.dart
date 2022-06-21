import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/top_places_pagination_model.dart';
import 'package:spott/models/api_responses/top_sports_pagination_model.dart';
import 'package:spott/utils/constants/api_constants.dart';

class TopPlacesApi {
  Future<TopPlacesPaginationModel> getTopPlacesData(
      {required String token,
      required double lat,
      required double lng,
      String? nextPageUrl}) async {
    try {
      final String finalUrl = nextPageUrl == null
          ? ApiConstants.baseUrl + ApiConstants.topPlacesApi
          : ApiConstants.baseUrl +
              ApiConstants.topPlacesApi +
              nextPageUrl.replaceAll('/', '');

      print("Get top places data => $token $lat $lng");
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
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        print("200000");
        return TopPlacesPaginationModel.fromJson(response.data);
      } else {
        return TopPlacesPaginationModel(status: 0);
      }
    } catch (e) {
      if (e is DioError) {
        print('top places screen data error => ${e.response!.data}');
        return TopPlacesPaginationModel(status: 0);
      } else {
        print('Explore screen data error => ${e.toString()}');

        return TopPlacesPaginationModel(status: 0);
      }
    }
  }
}
