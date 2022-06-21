import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/place_stories_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';

part 'place_stories_state.dart';

class PlaceStoriesCubit extends Cubit<PlaceStoriesState> {
  PlaceStoriesCubit() : super(PlaceStoriesInitial());

  final Repository _repository = Repository();

  Future<void> getAllPosts({required String id}) async {
    emit(LoadingData());
    final PlaceStoriesApiResponse apiResponse =
    await _repository.placeAllStories(token: AppData.accessToken!, id: id);
    if (apiResponse.status == 1) {
      emit(FetchedUserPostsSuccessfully(apiResponse.stories));
    } else {
      emit(ErrorState(apiResponse.message ?? LocaleKeys.getPostFailed.tr()));
    }
  }


}
