// import 'package:spott/models/api_responses/general_api_response.dart';
// import 'package:spott/models/data_models/app_notification.dart';
//
// class GetNotificationsApiResponse extends GeneralApiResponse {
//   List<AppNotification>? _notifications;
//
//   List<AppNotification>? get notifications => _notifications;
//
//   GetNotificationsApiResponse(
//       {int? status, String? message, List<AppNotification>? notifications})
//       : super(status: status, message: message) {
//     _notifications = notifications;
//   }
//
//   GetNotificationsApiResponse.fromJson(dynamic json) : super.fromJson(json) {
//     if (json != null && json["notifications"] != null) {
//       _notifications = [];
//       json["notifications"].forEach((v) {
//         _notifications?.add(AppNotification.fromJson(v));
//       });
//     }
//   }
// }
