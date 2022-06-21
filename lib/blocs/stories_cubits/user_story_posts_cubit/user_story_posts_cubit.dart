import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/user_all_story_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';

part 'user_story_posts_state.dart';

class UserStoryPostsCubit extends Cubit<UserStoryPostsState> {
  UserStoryPostsCubit() : super(UserStoryPostsInitial());

  final Repository _repository = Repository();

  Future<void> getAllPosts({required String id}) async {
    emit(LoadingData());
    final UserAllStoryApiResponse apiResponse =
    await _repository.getAllUserPosts(token: AppData.accessToken!, id: id);
    if (apiResponse.status == 1) {
      emit(FetchedUserPostsSuccessfully(apiResponse.posts));
    } else {
      emit(ErrorState(apiResponse.message ?? LocaleKeys.getPostFailed.tr()));
    }
  }


}
