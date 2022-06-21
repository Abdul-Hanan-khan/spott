import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:spott/models/api_responses/get_app_notifications_model.dart';
import 'package:spott/models/api_responses/get_notification_api_response.dart';
import 'package:spott/models/api_responses/mark_notifications_read_api_response.dart';
import 'package:spott/models/api_responses/update_user_notification_token_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:spott/utils/show_snack_bar.dart';

import '../app_data.dart';

class NotificationsApiProvider {
  Future<GetAppNotificationsModel> getNotifications(String _token) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio
          .get(ApiConstants.baseUrl + ApiConstants.getNotificationsUrl);
      if (response.statusCode == 200) {
        print("Notification api response => ${response.statusCode}");

        GetAppNotificationsModel responses = GetAppNotificationsModel.fromJson(
            response.data as Map<dynamic, dynamic>);
        return responses;
      } else {
        return GetAppNotificationsModel(status: 0);
      }
    } catch (e) {
      if (e is DioError) {
        print('Notification api error 1 ${e.toString()}');
        return GetAppNotificationsModel.fromJson(e.response?.data as Map);
      } else {
        print('Notification api error ${e.toString()}');
        return GetAppNotificationsModel(status: 0);
      }
    }
  }

  Future<UpdateUserNotificationTokenApiResponse> updateUserNotificationToken(
    String _token,
    String _oneSignalToken,
  ) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.updateNotificationTokenUrl,
          data: FormData.fromMap({'one_signal_token': _oneSignalToken}));
      if (response.statusCode == 200) {
        return UpdateUserNotificationTokenApiResponse.fromJson(response.data);
      } else {
        return UpdateUserNotificationTokenApiResponse(
            message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return UpdateUserNotificationTokenApiResponse.fromJson(
          e.response?.data,
        );
      } else {
        return UpdateUserNotificationTokenApiResponse(message: e.toString());
      }
    }
  }

  Future<MarkNotificationsReadApiResponse> markNotificationsRead(
      String _token, List<int> _ids) async {
    try {
      final Dio dio = Dio();

      ApiConstants.header(_token, dio);

      final Response response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.markNotificationsReadUrl,
        data: {'notification_ids': _ids},
      );
      if (response.statusCode == 200) {
        // print("notification read => ${_ids.length}");

        return MarkNotificationsReadApiResponse.fromJson(response.data);
      } else {
        return MarkNotificationsReadApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return MarkNotificationsReadApiResponse.fromJson(e.response?.data);
      } else {
        return MarkNotificationsReadApiResponse(message: e.toString());
      }
    }
  }

  sendMessageNotification(String userId, BuildContext context) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) async {
        if (value.get('userState') == 0) {
          final api = ApiConstants.baseUrl + ApiConstants.sendNotification;

          final Map<String, String> headers = {
            "Authorization": "Bearer ${AppData.accessToken}",
          };

          final response = await http.post(
            Uri.parse(api),
            body: {'user_id': userId},
            headers: headers,
          );

          if (response.statusCode == 200) {
            // showSnackBar(context: context, message: 'Message sent');
            FirebaseFirestore.instance
                .collection('users')
                .doc(userId.toString())
                .get()
                .then((value) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId.toString())
                  .set({
                'userState': 0,
                'isNewMessage': value.get('isNewMessage')
              });
            });
          } else {}
        } else {
          print("good to go ");
        }
      });
    } catch (e) {}
  }
}
