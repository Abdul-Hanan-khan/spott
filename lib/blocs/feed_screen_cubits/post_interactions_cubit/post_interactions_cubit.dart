import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_post_interaction_api_response.dart';
import 'package:spott/models/data_models/post_interaction.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'post_interactions_state.dart';

class PostInteractionsCubit extends Cubit<PostInteractionsCubitState> {
  final Repository _repository = Repository();

  PostInteractionsCubit() : super(PostLikesInitial());

  Future<void> getPostInteractions(int? _postId) async {
    if (AppData.accessToken != null && _postId != null) {
      emit(FetchingPostInteractions());
      final GetPostInteractionApiResponse apiResponse = await _repository
          .getPostInteractions(AppData.accessToken!, _postId.toString());
      if (apiResponse.status == ApiResponse.success &&
          apiResponse.data != null) {
        emit(PostInteractionsFetched(apiResponse));
      } else {
        emit(
          ErrorState(
            apiResponse.message ?? LocaleKeys.failedToFetchLikes.tr(),
          ),
        );
      }
    }
  }
}
