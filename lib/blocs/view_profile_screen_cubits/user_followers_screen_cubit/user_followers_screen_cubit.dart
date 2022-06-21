import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_user_followers_api_response.dart';
import 'package:spott/models/data_models/follow.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'user_followers_screen_cubit_state.dart';

class UserFollowersScreenCubit extends Cubit<UserFollowersScreenCubitState> {
  UserFollowersScreenCubit() : super(UserFollowersScreenCubitInitial());
  final Repository _repository = Repository();

  Future<void> getFollowers(int? userId) async {
    if (AppData.accessToken != null && userId != null) {
      emit(FetchingFollowers());
      final GetUserFollowersApiResponse _apiResponse =
          await _repository.getUserFollowers(AppData.accessToken!, userId);
      if (_apiResponse.status == ApiResponse.success) {
        emit(FollowerFetchedSuccessfully(_apiResponse.followers!));
      } else {
        emit(FailedToFetchFollowers(_apiResponse.message));
      }
    }
  }
}
