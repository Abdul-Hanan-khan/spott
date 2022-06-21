import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/all_rating_api_response_model.dart';
import 'package:spott/resources/repository.dart';

part 'all_rating_state.dart';

class AllRatingCubit extends Cubit<AllRatingState> {
  AllRatingCubit() : super(AllRatingInitial());

  Future getAllRatings(String placeId, String token) async {
    final Repository repository = Repository();
    final AllRatingApiResponseModel allRatingApiResponseModel =
        await repository.getAllRating(placeId, token);

    if (allRatingApiResponseModel.status == 1) {
      emit(
        AllRatingSuccessState(
          allRatingApiResponseModel,
        ),
      );
    } else {
      emit(
        AllRatingFailedState(
          allRatingApiResponseModel,
        ),
      );
    }
  }
}
