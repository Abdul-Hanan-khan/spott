import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/add_comment_api_response.dart';
import 'package:spott/models/api_responses/delete_comment_api_response.dart';
import 'package:spott/models/api_responses/get_comments_api_response.dart';
import 'package:spott/models/api_responses/view_post_api_model.dart';
import 'package:spott/models/data_models/comment.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'comments_cubit_state.dart';

class CommentsCubit extends Cubit<CommentsCubitState> {
  final Repository _repository = Repository();

  CommentsCubit() : super(CommentsInitial());

  Future<void> addNewComment(int? _postId, String comment) async {
    if (AppData.accessToken != null && _postId != null) {
      emit(AddingNewComment());
      final AddCommentApiResponse apiResponse = await _repository.addComment(
        token: AppData.accessToken!,
        postId: _postId.toString(),
        comment: comment,
      );
      if (apiResponse.status == ApiResponse.success &&
          apiResponse.comment != null) {
        emit(CommentAddedSuccessfully(_postId, apiResponse.comment!));
      } else {
        emit(
          FailedState(
            apiResponse.message ?? LocaleKeys.failedToAddComment.tr(),
          ),
        );
      }
    }
  }

  Future<void> getAllComments(int? _postId, {bool isRefreshing = false}) async {
    if (AppData.accessToken != null && _postId != null) {
      emit(AddingNewComment());
      final GetCommentsApiResponse apiResponse = await _repository
          .getAllComments(AppData.accessToken!, _postId.toString());
      if (apiResponse.status == ApiResponse.success &&
          apiResponse.data != null) {
        emit(CommentsFetched(apiResponse.data!));
      } else {
        emit(
          FailedState(
            apiResponse.message ?? LocaleKeys.failedToFetchComments.tr(),
          ),
        );
      }
    }
  }

  Future<void> deleteComment(
      {required commentId, bool isRefreshing = false}) async {
    emit(isRefreshing ? RefreshingComments() : FetchingComments());
    if (AppData.accessToken != null && commentId != null) {
      final DeleteCommentApiResponse apiResponse = await _repository
          .deleteComment(token: AppData.accessToken!, commentId: commentId);
      if (apiResponse.status == 1) {
        print("Sucessss");
      } else {
        print("Failed");
      }
    }
  }
}
