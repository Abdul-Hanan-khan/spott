import 'package:spott/models/api_responses/general_api_response.dart';

class UnblockUserApiResponse extends GeneralApiResponse {
  UnblockUserApiResponse({int? status, String? message})
      : super(status: status, message: message);

  UnblockUserApiResponse.fromJson(dynamic json) : super.fromJson(json);
}
