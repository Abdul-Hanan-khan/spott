import 'package:spott/models/api_responses/general_api_response.dart';

class MarkNotificationsReadApiResponse extends GeneralApiResponse {
  MarkNotificationsReadApiResponse({int? status, String? message})
      : super(status: status, message: message);

  MarkNotificationsReadApiResponse.fromJson(dynamic json)
      : super.fromJson(json);
}
