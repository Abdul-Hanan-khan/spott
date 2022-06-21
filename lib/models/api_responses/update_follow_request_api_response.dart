import 'package:spott/models/api_responses/general_api_response.dart';

class UpdateFollowRequestApiResponse extends GeneralApiResponse {
  UpdateFollowRequestApiResponse({int? status, String? message})
      : super(status: status, message: message);

  UpdateFollowRequestApiResponse.fromJson(dynamic json) : super.fromJson(json);
}
