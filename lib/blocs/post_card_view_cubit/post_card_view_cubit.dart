import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/api_responses/block_user_api_response.dart';
import 'package:spott/models/api_responses/like_dislike_api_response.dart';
import 'package:spott/models/api_responses/report_content_api_response.dart';
import 'package:spott/models/api_responses/request_spot_api_response.dart';
import 'package:spott/models/api_responses/simple_api_response_model.dart';
import 'package:spott/models/api_responses/view_post_api_model.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/show_snack_bar.dart';

part 'post_card_view_state.dart';

class PostCardViewCubit extends Cubit<PostCardViewState> {
  final Repository _repository = Repository();

  PostCardViewCubit() : super(const PostCardViewInitial(0));

  Future<void> blockUser(int? _postId, int? _userId) async {
    if (AppData.accessToken != null && _postId != null && _userId != null) {
      emit(UpdatingPost(_postId));
      final BlockUserApiResponse _apiResponse =
          await _repository.blockUser(AppData.accessToken!, _userId.toString());
      if (_apiResponse.status == ApiResponse.success) {
        emit(UserBlocked(_postId, _apiResponse));
      } else {
        emit(
          ErrorState(
            _postId,
            _apiResponse.message ?? LocaleKeys.failedToBlockUser.tr(),
          ),
        );
      }
    }
  }

  Future<bool> deletePost(int postId, BuildContext context) async {
    final SimpleApiResponseModel simpleApiResponseModel =
        await Repository().deletePost(postId);
    if (simpleApiResponseModel.status == 1) {
      showSnackBar(
          context: context, message: simpleApiResponseModel.message.toString());
      return true;
    } else {
      showSnackBar(
          context: context, message: simpleApiResponseModel.message.toString());
      return false;
    }
  }

  void commentAdd(int? _postId) {
    if (_postId != null) {
      emit(UpdatingPost(_postId));
      emit(CommentCountUpdated(_postId));
    }
  }


  Future<void> likePost(int? _postId, int reactKey) async {
    print("React key $reactKey");
    if (AppData.accessToken != null && _postId != null) {
      emit(UpdatingPost(_postId));
      final LikeDislikeApiResponse apiResponse = await _repository.reactPost(
        token: AppData.accessToken!,
        postId: _postId.toString(),
        reactKey: reactKey,
      );
      print("react 22 => ${apiResponse.data.toString()}");
      if (apiResponse.status == ApiResponse.success) {
        emit(PostLiked(_postId));
        emit(UpdatingPost(_postId));
      } else {
        emit(
          ErrorState(
            _postId,
            apiResponse.message ?? LocaleKeys.postLikeFailed.tr(),
          ),
        );
      }
    }
  }

  Future<void> reportPost(
    int? _postId,
  ) async {
    if (AppData.accessToken != null && _postId != null) {
      emit(UpdatingPost(_postId));
      final ReportContentApiResponse _apiResponse =
          await _repository.reportContent(
        token: AppData.accessToken!,
        contentId: _postId,
        type: 'post',
      );
      if (_apiResponse.status == ApiResponse.success) {
        emit(PostReported(_postId, _apiResponse));
      } else {
        emit(
          ErrorState(
            _postId,
            _apiResponse.message ?? LocaleKeys.failedToBlockUser.tr(),
          ),
        );
      }
    }
  }

  Future<void> requestSpot(int? _postId) async {
    if (AppData.accessToken != null && _postId != null) {
      emit(LoadingState(_postId));
      final RequestSpotApiResponse _apiResponse = await _repository.requestPostSpot(AppData.accessToken!, _postId.toString());
      if (_apiResponse.status == ApiResponse.success) {
        emit(SpottRequestStatusUpdated(_postId, _apiResponse.spot));
      } else {
        emit(
          ErrorState(
            _postId,
            _apiResponse.message ?? LocaleKeys.spotRequestFailed.tr(),
          ),
        );
      }
    }
  }
}
