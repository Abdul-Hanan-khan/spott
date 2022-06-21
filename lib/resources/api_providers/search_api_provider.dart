import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/search_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class SearchApiProvider {
  Future<SearchApiResponse> search(
      {required String token, required String keyWord}) async {
    try {
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.searchApiUrl,
        data: FormData.fromMap(
          {'search': keyWord},
        ),
      );
      if (response.statusCode == 200) {
        return SearchApiResponse.fromJson(response.data);
      } else {
        return SearchApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return SearchApiResponse.fromJson(e.response?.data);
      } else {
        return SearchApiResponse(message: e.toString());
      }
    }
  }
}
