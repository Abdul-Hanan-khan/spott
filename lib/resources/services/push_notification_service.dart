import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/utils/constants/services_constants.dart';

class PushNotificationService {
  static final PushNotificationService _singleton =
      PushNotificationService._internal();

  static final Repository _repository = Repository();

  factory PushNotificationService() {
    OneSignal.shared.setAppId(OneSignalConstants.appId);
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      debugPrint("Accepted permission: $accepted");
    });

    OneSignal.shared.getDeviceState().then((value) {
      _oneSignalUserId = value?.userId;
      if (_oneSignalUserId != null && AppData.accessToken != null) {
        _repository.updateUserNotificationToken(
            AppData.accessToken!, _oneSignalUserId!);
      }
    });
    return _singleton;
  }

  PushNotificationService._internal();

  static String? _oneSignalUserId;

  static String? get oneSignalUserId => _oneSignalUserId;
}
