import 'general_api_response.dart';

class ChangePasswordApiResponse extends GeneralApiResponse {
  ChangePasswordApiResponse({int? status, String? message})
      : super(status: status, message: message);

  ChangePasswordApiResponse.fromJson(dynamic json) : super.fromJson(json);
}
