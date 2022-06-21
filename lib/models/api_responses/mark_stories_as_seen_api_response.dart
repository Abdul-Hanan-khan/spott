import 'package:spott/models/api_responses/general_api_response.dart';

class MarkStoriesAsSeenApiResponse extends GeneralApiResponse {
  MarkStoriesAsSeenApiResponse({int? status, String? message})
      : super(status: status, message: message);

  MarkStoriesAsSeenApiResponse.fromJson(dynamic json) : super.fromJson(json);
}
