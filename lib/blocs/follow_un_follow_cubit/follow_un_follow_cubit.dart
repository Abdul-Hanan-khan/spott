import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/follow_user_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'follow_un_follow_cubit_state.dart';

class FollowUnFollowCubit extends Cubit<FollowUnFollowState> {
  final Repository _repository = Repository();

  FollowUnFollowCubit() : super(FollowUnFollowInitial());

  Future<void> followUser(int? userId) async {
    if (userId != null &&
        AppData.accessToken != null &&
        AppData.currentUser?.id != null) {
      emit(LoadingState());
      final FollowUserApiResponse _apiResponse = await _repository.followUser(
        token: AppData.accessToken!,
        userId: userId,
        followerId: AppData.currentUser!.id!,
      );
      if (_apiResponse.status == ApiResponse.success) {
        emit(UserFollowedSuccessfully(_apiResponse));
      } else {
        emit(
          ErrorState(_apiResponse.message ?? LocaleKeys.failedToFollow.tr()),
        );
      }
    }
  }

  Future<void> unFollowUser(int? userId) async {
    if (userId != null &&
        AppData.accessToken != null &&
        AppData.currentUser?.id != null) {
      emit(LoadingState());
      final FollowUserApiResponse _apiResponse = await _repository.unFollowUser(
        token: AppData.accessToken!,
        userId: userId,
        followerId: AppData.currentUser!.id!,
      );
      if (_apiResponse.status == ApiResponse.success) {
        emit(UserUnFollowedSuccessfully(_apiResponse));
      } else {
        emit(
          ErrorState(_apiResponse.message ?? LocaleKeys.failedToUnFollow.tr()),
        );
      }
    }
  }
}
