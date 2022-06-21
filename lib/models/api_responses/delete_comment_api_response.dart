import 'general_api_response.dart';

class DeleteCommentApiResponse extends GeneralApiResponse {
  DeleteCommentApiResponse({int? status, String? message})
      : super(status: status, message: message);

  DeleteCommentApiResponse.fromJson(dynamic json) : super.fromJson(json);
}
