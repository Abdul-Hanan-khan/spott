import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/report_content_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class ReportContentApiProvider{
  Future<ReportContentApiResponse> reportContent({required String token,required int contentId,required String type}) async {
      try {
        final Dio dio = Dio();
        ApiConstants.header(token, dio);
        final Response response =
            await dio.post(ApiConstants.baseUrl + ApiConstants.reportContentUrl,
                data: FormData.fromMap({
                  'content_id': contentId,
                  'type': type
                }));
        if (response.statusCode == 200) {
          return ReportContentApiResponse.fromJson(response.data);
        } else {
          return ReportContentApiResponse(message: response.toString());
        }
      } catch (e) {
        if (e is DioError) {
          return ReportContentApiResponse.fromJson(e.response?.data);
        } else {
          return ReportContentApiResponse(message: e.toString());
        }
      }
    }
}