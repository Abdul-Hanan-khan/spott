import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/add_rating_response_model.dart';
import 'package:spott/resources/repository.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  Future<void> placeRating(
      String review, String rating, String placeId, String token) async {
    emit(RatingLoading());
    final AddRatingResponseModel ratingResponseModel =
        await Repository().placeRating(review, rating, placeId, token);

    emit(RatingFailed());

    if (ratingResponseModel.rating != null) {
      emit(RatingSuccess(ratingResponseModel.message.toString()));
    } else {
      emit(RatingFailed());
    }
  }
}
