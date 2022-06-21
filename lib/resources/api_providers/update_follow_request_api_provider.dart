import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/update_follow_request_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/enums.dart';

class UpdateFollowRequestApiProvider {
  Future<UpdateFollowRequestApiResponse> updateFollowRequestStatus(
      {required String token, required Map data}) async {

    print(data);

    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.followRequestUrl,
        data: data,


        // FormData.fromMap(
        //   {
        //     'request_id': requestId,
        //     'status':'accept'
        //
        //   },
        // ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        return UpdateFollowRequestApiResponse.fromJson(response.data);
      } else {
        return UpdateFollowRequestApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UpdateFollowRequestApiResponse.fromJson(e.response?.data);
      } else {
        return UpdateFollowRequestApiResponse(message: e.toString());
      }
    }
  }
}
