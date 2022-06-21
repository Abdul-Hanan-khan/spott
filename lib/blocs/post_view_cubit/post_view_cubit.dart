import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/blocs/feed_screen_cubits/comments_cubit/comments_cubit.dart';
import 'package:spott/models/api_responses/add_comment_api_response.dart';
import 'package:spott/models/api_responses/delete_comment_api_response.dart';
import 'package:spott/models/api_responses/get_comments_api_response.dart';
import 'package:spott/models/api_responses/request_spot_api_response.dart';
import 'package:spott/models/api_responses/view_post_api_model.dart';
import 'package:spott/models/data_models/spot.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/models/data_models/comment.dart';

part 'post_view_state.dart';

class PostViewCubit extends Cubit<PostViewState> {
  final Repository _repository = Repository();
  List<Comment> comments = [];

  PostViewCubit() : super(PostViewInitial());

  Future<void> getPostView(int postId) async {
    emit(PostViewLoadingState());
    print("hhhhhhhhhhhhhh");
    getAllComments(postId);
    final ViewPostApiModel viewPostApiModel =
        await Repository().getPostData(postId);
    if (viewPostApiModel.status == 1) {
      emit(PostViewSuccessState(viewPostApiModel));
    } else {
      emit(PostViewFailedState(viewPostApiModel));
    }
  }

  Future<void> addNewComment(int? _postId, String comment) async {
    if (AppData.accessToken != null && _postId != null) {
      final AddCommentApiResponse apiResponse = await _repository.addComment(
        token: AppData.accessToken!,
        postId: _postId.toString(),
        comment: comment,
      );
      if (apiResponse.status == ApiResponse.success &&
          apiResponse.comment != null) {
        getPostView(_postId);
      } else {}
    }
  }

  Future<void> getAllComments(int? _postId, {bool isRefreshing = false}) async {
    if (AppData.accessToken != null && _postId != null) {
      final GetCommentsApiResponse apiResponse = await _repository
          .getAllComments(AppData.accessToken!, _postId.toString());
      if (apiResponse.status == 1) {
        comments = apiResponse.data!;
        print("Sucessss");
        emit(PostCommentsFetched());
      } else {
        print("Failed");
        emit(PostCommentsFetched());
      }
    }
  }

  Future<void> deleteComment(
      {required commentId}) async {
    // emit(isRefreshing ? PostViewLoadingState() : PostViewLoadingState());
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

  Future<void> requestSpot(int? _postId) async {
    if (AppData.accessToken != null && _postId != null) {
      final RequestSpotApiResponse _apiResponse = await _repository.requestPostSpot(AppData.accessToken!, _postId.toString());
      if (_apiResponse.status == ApiResponse.success) {
        emit(SpottRequestStatusUpdated(_apiResponse.spot));
        getPostView(_postId);
      } else {
        emit(
          ErrorState(
            _postId,
            _apiResponse.message ?? LocaleKeys.spotRequestFailed.tr(),
          ),
        );
      }
    }
  }
}
