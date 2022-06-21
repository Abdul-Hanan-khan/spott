import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/spotted_posts_api_response.dart';
import 'package:spott/models/data_models/place_spotted_list_model.dart';
import 'package:spott/resources/repository.dart';

part 'spotted_list_view_state.dart';

class SpottedListViewCubit extends Cubit<SpottedListViewState> {
  SpottedListViewCubit() : super(SpottedListViewInitial());

  getSpottedListView(String placeId) async {
    emit(SpottedListViewLoading());
    final SpottedPostsApiResponse placeSpottedListModel =
        await Repository().getSpottedListModel(placeId);

    if (placeSpottedListModel.status == 1) {
      emit(SpottedListViewSuccessState(placeSpottedListModel));
    } else {
      emit(SpottedListViewFailedState(placeSpottedListModel));
    }
  }
}
