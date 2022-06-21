import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_user_following_api_response.dart';
import 'package:spott/models/data_models/follow.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'user_following_screen_cubit_state.dart';

class UserFollowingScreenCubit extends Cubit<UserFollowingScreenCubitState> {
  UserFollowingScreenCubit() : super(UserFollowingScreenCubitInitial());
  final Repository _repository = Repository();

  Future<void> getFollowing(int? userId) async {
    if (AppData.accessToken != null && userId != null) {
      emit(FetchingFollowing());
      final GetUserFollowingApiResponse _apiResponse =
          await _repository.getUserFollowing(AppData.accessToken!, userId);
      if (_apiResponse.status == ApiResponse.success) {
        emit(FollowingFetchedSuccessfully(_apiResponse.followers!));
      } else {
        emit(FailedToFetchFollowing(_apiResponse.message));
      }
    }
  }
}
