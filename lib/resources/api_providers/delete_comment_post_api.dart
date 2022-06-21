

import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/delete_comment_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class DeleteCommentPostApi{

  Future<DeleteCommentApiResponse> deleteComment(
      {required String token,
        required int commentId}) async {
    try {
      final dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.deleteCommentApi,
        data: FormData.fromMap(
          {
            'comment_id': commentId,
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Follow result =>  ${response.data}");
        return DeleteCommentApiResponse.fromJson(response.data);
      } else {

        return DeleteCommentApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print("Follow result => ${e.response!.data}");
        return DeleteCommentApiResponse.fromJson(e.response?.data);
      } else {
        return DeleteCommentApiResponse(message: e.toString());
      }
    }
  }
}