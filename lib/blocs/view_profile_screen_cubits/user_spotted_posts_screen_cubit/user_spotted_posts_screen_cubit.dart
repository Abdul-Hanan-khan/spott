import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_user_spotted_posts_api_response.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'user_spotted_posts_screen_cubit_state.dart';

class UserSpottedPostsScreenCubit
    extends Cubit<UserSpottedPostsScreenCubitState> {
  UserSpottedPostsScreenCubit() : super(UserSpottedPostsScreenCubitInitial());
  final Repository _repository = Repository();

  Future<void> fetchPosts(int? _userId) async {
    if (_userId != null && AppData.accessToken != null) {
      emit(FetchingPosts());
      final GetUserSpottedPostsApiResponse _apiResponse =
          await _repository.getUserSpottedPosts(AppData.accessToken!, _userId);
      if (_apiResponse.status == ApiResponse.success) {
        emit(PostsFetchedSuccessfully(_apiResponse.posts));
      } else {
        emit(FailedToFetchPosts(_apiResponse.message));
      }
    }
  }
}
