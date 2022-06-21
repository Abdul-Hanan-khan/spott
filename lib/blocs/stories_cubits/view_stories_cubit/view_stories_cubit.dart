import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/block_user_api_response.dart';
import 'package:spott/models/api_responses/mark_stories_as_seen_api_response.dart';
import 'package:spott/models/api_responses/report_content_api_response.dart';
import 'package:spott/models/api_responses/request_spot_api_response.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

import '../../../models/api_responses/post_seen_api_response.dart';

part 'view_stories_cubit_state.dart';

class ViewStoriesCubit extends Cubit<ViewStoriesCubitState> {
  final Repository _repository = Repository();

  ViewStoriesCubit() : super(ViewStoriesCubitInitial());

  Future<void> blockUser(int? _userId) async {
    if (AppData.accessToken != null && _userId != null) {
      emit(UpdatingStory());
      final BlockUserApiResponse _apiResponse =
          await _repository.blockUser(AppData.accessToken!, _userId.toString());
      if (_apiResponse.status == ApiResponse.success) {
        emit(UserBlocked(_apiResponse));
      } else {
        emit(FailedState(
            _apiResponse.message ?? LocaleKeys.failedToBlockUser.tr()));
      }
    }
  }

  Future<void> markStoryAsSeen(int? id) async {
    if (AppData.accessToken != null && id != null) {
      emit(UpdatingStory());
      final MarkStoriesAsSeenApiResponse _apiResponse =
          await _repository.markStoryAsSeen(AppData.accessToken!, id);
      if (_apiResponse.status == ApiResponse.success) {
        emit(StoryMarkedAsSeen());
      } else {
        emit(
          FailedState(
              _apiResponse.message ?? LocaleKeys.failedToMarkStoryAsSeen.tr()),
        );
      }
    }
  }
  Future<void> markPostAsSeen(int? id) async {
    // print("\n\n\nn\n\n");
    // print(id);
    // print("\n\n\nn\n\n");
    if (AppData.accessToken != null && id != null) {
      // emit(UpdatingStory());
      print("\n\n\nn\n\n");
      print(id);
      print("\n\n\nn\n\n");
      final PostSeenApiResponse _apiResponse =
      await _repository.markPostAsSeen(AppData.accessToken!, id);
      if (_apiResponse.status == 1) {
        emit(StoryMarkedAsSeen());
      } else {
        emit(
          FailedState(
              _apiResponse.message ?? LocaleKeys.failedToMarkStoryAsSeen.tr()),
        );
      }
    }
  }

  Future<void> reportStory(
    int? _storyId,
  ) async {
    if (AppData.accessToken != null && _storyId != null) {
      emit(UpdatingStory());
      final ReportContentApiResponse _apiResponse =
          await _repository.reportContent(
              token: AppData.accessToken!, contentId: _storyId, type: 'story');
      if (_apiResponse.status == ApiResponse.success) {
        emit(StoryReported(_apiResponse));
      } else {
        emit(FailedState(_apiResponse.message));
      }
    }
  }

  Future<void> requestSpot(int? _storyId) async {
    if (AppData.accessToken != null && _storyId != null) {
      emit(UpdatingStory());
      final RequestSpotApiResponse _apiResponse = await _repository
          .requestStorySpot(AppData.accessToken!, _storyId.toString());
      if (_apiResponse.status == ApiResponse.success) {
        emit(SpottRequestStatusUpdated(_apiResponse.spot));
      } else {
        emit(FailedState(_apiResponse.message));
      }
    }
  }
}
