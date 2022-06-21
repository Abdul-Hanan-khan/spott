import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/api_responses/get_app_notifications_model.dart'
    as notifications;
import 'package:spott/models/api_responses/get_notification_api_response.dart';
import 'package:spott/models/api_responses/mark_notifications_read_api_response.dart';
import 'package:spott/models/api_responses/update_follow_request_api_response.dart';
import 'package:spott/models/api_responses/update_spot_request_status_api_response.dart';
import 'package:spott/models/data_models/app_notification.dart';
import 'package:spott/resources/api_providers/spot_request_accept_model.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/enums.dart';

part 'activity_screen_state.dart';

class ActivityScreenCubit extends Cubit<ActivityScreenState> {
  final Repository _repository = Repository();

  final StreamController<int> countStreamController =
      StreamController<int>.broadcast();

  final List<notifications.Notifications> _nearbyNotifications = [];

  final List<notifications.Notifications> _youNotifications = [];

  ActivityScreenCubit() : super(ActivityScreenInitial());

  List<notifications.Notifications> get nearbyNotifications =>
      _nearbyNotifications;

  List<notifications.Notifications> get youNotifications => _youNotifications;

  Future<void> acceptSpotRequest(
      dynamic _notificationId, dynamic _spottId, BuildContext context) async {
    if (AppData.accessToken != null && _spottId != null) {
      print("Accept spot ");
      emit(UpdatingSpotRequestStatus());
      final SpotRequestAcceptModel _apiResponse =
          await _repository.acceptSpotRequest(AppData.accessToken, _spottId);
      if (_apiResponse.status == ApiResponse.success) {
        if (_notificationId != null) {
          markNotificationsRead([int.parse(_notificationId.toString())]);
        }
        emit(SpotRequestUpdated());
      } else {
        Navigator.pop(context);
        emit(
          NotificationsErrorState(
            _apiResponse.message.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    countStreamController.close();
    return super.close();
  }

  Future<void> getInitialNotifications() async {
    if (AppData.accessToken != null) {
      emit(FetchingNotifications());
      _getNotifications(AppData.accessToken!);
    }
  }

  Future<void> markNotificationsRead(List<int> _ids) async {
    // print("Ids => ${_ids.length}");
    if (AppData.accessToken != null && _ids.isNotEmpty) {
      print("trying to update 2");

      emit(UpdatingNotifications());
      final MarkNotificationsReadApiResponse _apiResponse =
          await _repository.markNotificationsRead(AppData.accessToken!, _ids);
      if (_apiResponse.status == ApiResponse.success) {
        for (final int id in _ids) {
          // _nearbyNotifications
          //     .firstWhereOrNull((element) => element.id == id)
          //     ?.markNotificationRead();
          // _youNotifications
          //     .firstWhereOrNull((element) => element.id == id)
          //     ?.markNotificationRead();
        }
        _updateCountStream(_nearbyNotifications + _youNotifications);
        emit(NotificationsMarkedRead());
      } else {
        emit(
          NotificationsErrorState(
            _apiResponse.message ??
                LocaleKeys.failedToMarkNotificationRead.tr(),
          ),
        );
      }
    }
  }

  Future<void> refreshNotifications() async {
    if (AppData.accessToken != null) {
      emit(RefreshingNotifications());
      _getNotifications(AppData.accessToken!);
    }
  }

  Future<void> rejectSpotRequest(int? _notificationId, dynamic _spotId) async {
    if (AppData.accessToken != null && _spotId != null) {
      emit(UpdatingSpotRequestStatus());
      final SpotRequestAcceptModel _apiResponse =
          await _repository.rejectSpotRequest(AppData.accessToken!, _spotId);
      if (_apiResponse.status == ApiResponse.success) {
        // _nearbyNotifications
        //     .firstWhereOrNull((element) => element.post?.spot?.id == _spotId)
        //     ?.post
        //     ?.spot
        //     ?.requestRejected();
        // _youNotifications
        //     .firstWhereOrNull((element) => element.post?.spot?.id == _spotId)
        //     ?.post
        //     ?.spot
        //     ?.requestRejected();

        if (_notificationId != null) {
          markNotificationsRead([_notificationId]);
        }
        emit(SpotRequestUpdated());
      } else {
        emit(
          NotificationsErrorState(
            _apiResponse.message.toString(),
          ),
        );
      }
    }
  }

  Future<void> updateFollowRequest(
    int? _notificationId,
    int? _followId,
    FollowRequestUpdateStatus _status,
  ) async {
    if (AppData.accessToken != null && _followId != null) {
      emit(UpdatingFollowRequest(_status));

      Map data;

      if(_status == 'accept'){
        data = {
          'request_id': _followId,
          'status':'accept'
        };
      }else{
        data = {
          'request_id': _followId,
          'status':'reject'
        };
      }
    //   {
    // //     'request_id': requestId,
    // // 'status':'accept'
    //
    // },

      final UpdateFollowRequestApiResponse _apiResponse =
          await _repository.updateFollowRequestStatus(
        token: AppData.accessToken!,data: data
      );
      if (_apiResponse.status == ApiResponse.success) {
        if (_status == FollowRequestUpdateStatus.accept) {
          // _nearbyNotifications
          //     .firstWhereOrNull((element) => element.follow?.id == _followId)
          //     ?.follow
          //     ?.requestAccepted();
          // _youNotifications
          //     .firstWhereOrNull((element) => element.follow?.id == _followId)
          //     ?.follow
          //     ?.requestAccepted();
        } else {
          // _nearbyNotifications
          //     .firstWhereOrNull((element) => element.follow?.id == _followId)
          //     ?.follow
          //     ?.requestRejected();
          // _youNotifications
          //     .firstWhereOrNull((element) => element.follow?.id == _followId)
          //     ?.follow
          //     ?.requestRejected();
        }
        if (_notificationId != null) {
          markNotificationsRead([_notificationId]);
        }
        emit(FollowRequestUpdated());
      } else {
        emit(
          NotificationsErrorState(
            _apiResponse.message ?? LocaleKeys.failedToUpdateFollowRequest.tr(),
          ),
        );
      }
    }
  }

  Future<void> _getNotifications(String _accessToken) async {
    final notifications.GetAppNotificationsModel apiResponse =
        await _repository.getNotifications(_accessToken);
    print('notification status ${apiResponse.status}');
    print('notification length 2 ${apiResponse.notifications!.length}');

    if (apiResponse.status == ApiResponse.success &&
        apiResponse.notifications != null) {
      _nearbyNotifications.clear();
      _youNotifications.clear();
      if (true) {
        print('notification length 2 ${apiResponse.notifications!.length}');

        for (int i = 0; i < apiResponse.notifications!.length; i++) {
          if (apiResponse.notifications![i].model == 'post') {
            _nearbyNotifications.add(apiResponse.notifications![i]);
          } else {
            _youNotifications.add(apiResponse.notifications![i]);
          }
        }
        emit(
          NotificationsFetchedSuccessFully(
            nearbyNotifications: _nearbyNotifications,
            youNotifications: _youNotifications,
          ),
        );
      } else {}
    } else {}
  }

  void _updateCountStream(List<notifications.Notifications> _notifications) {
    countStreamController.add(
      _notifications
          .where((element) => element.status == AppNotificationStatus.unread)
          .length,
    );
  }
}
