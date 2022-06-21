import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/block_user_api_response.dart';
import 'package:spott/models/api_responses/get_share_able_link_api_response.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'view_user_profile_state.dart';

class ViewUserProfileCubit extends Cubit<ViewUserProfileState> {
  ViewUserProfileCubit() : super(ViewUserProfileInitial());
  final Repository _repository = Repository();

  Future<void> viewUserProfile(int? _userId) async {
    if (AppData.accessToken != null && _userId != null) {
      emit(LoadingState());
      final ViewProfileApiResponse apiResponse = await _repository
          .viewProfileApiProvider(AppData.accessToken!, _userId);
      if (apiResponse.status == ApiResponse.success &&
          apiResponse.profile != null) {
        emit(FetchedViewUserProfile(apiResponse));
      } else {
        emit(FailedToFetchProfileState(
            apiResponse.message ?? LocaleKeys.viewUserProfileFailed.tr()));
      }
    }
  }

  Future<void> blockUser(int? _userId) async {
    if (AppData.accessToken != null && _userId != null) {
      emit(BlockingUser());
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

  Future<void> getShareAbleLink(int? _userId) async {
    if (AppData.accessToken != null && _userId != null) {
      emit(LoadingState());
      final GetShareAbleLinkApiResponse _apiResponse =
          await _repository.getUserProfileLink(AppData.accessToken!, _userId);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.link != null) {
        emit(UserShareLinkFetched(_apiResponse.link!));
      } else {
        emit(FailedState(_apiResponse.message));
      }
    }
  }
}
