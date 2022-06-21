import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/post_reacts_model.dart';
import 'package:spott/resources/repository.dart';

part 'post_reacts_state.dart';

class PostReactsCubit extends Cubit<PostReactsState> {
  PostReactsCubit() : super(PostReactsInitial());

  getAllReacts(String postId) async {
    emit(PostReactsLoadingState());
    final PostReactsModel postReactsModel =
        await Repository().getAllReacts(postId);

    if (postReactsModel.status == 1) {
      emit(PostReactsSuccessState(postReactsModel));
    } else {
      emit(PostReactsFailedState(postReactsModel));
    }
  }
}
