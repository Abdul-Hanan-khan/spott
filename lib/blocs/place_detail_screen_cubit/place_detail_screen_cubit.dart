import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/get_place_detail_api_response.dart';
import 'package:spott/models/api_responses/get_share_able_link_api_response.dart';
import 'package:spott/models/api_responses/place_follow_api_model.dart';
import 'package:spott/models/api_responses/place_un_follow_api_model.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'place_detail_screen_cubit_state.dart';

class PlaceDetailScreenCubit extends Cubit<PlaceDetailScreenCubitState> {
  final Repository _repository = Repository();

  PlaceDetailScreenCubit() : super(PlaceDetailScreenCubitInitial());

  Future<void> fetchPlaceDetail(String? id) async {
    if (AppData.accessToken != null && id != null) {
      emit(LoadingState());
      final GetPlaceDetailApiResponse _apiResponse =
          await _repository.getPlaceDetail(AppData.accessToken!, id);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.place != null) {
        emit(PlaceDetailFetched(_apiResponse.place!));
      } else {
        emit(
          FailedToFetchDetail(
            _apiResponse.message ?? LocaleKeys.failedToFetchPlaceDetail.tr(),
          ),
        );
      }
    }
  }

  Future<void> getShareAbleLink(String? _placeId) async {
    if (AppData.accessToken != null && _placeId != null) {
      emit(LoadingState());
      final GetShareAbleLinkApiResponse _apiResponse = await _repository
          .getPlaceShareAbleLink(AppData.accessToken!, _placeId);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.link != null &&
          _apiResponse.link != null) {
        emit(ShareAbleLinkFetched(_apiResponse.link!));
      } else {
        emit(FailedToGetShareAbleLink(_apiResponse.message));
      }
    }
  }

  Future<void> followScreen(String placeId) async {
    emit(LoadingState());
    final PlaceFollowApiModel placeFollowApiModel =
        await Repository().followPlace(placeId);
    if (placeFollowApiModel.status == 1) {
      emit(PlaceFollowState(placeFollowApiModel));
    } else {
      emit(PlaceFollowErrorState(placeFollowApiModel));
    }
  }

  Future<void> unfollow(String placeId) async {
    emit(LoadingState());
    final PlaceUnFollowApiModel placeUnFollowApiModel =
        await Repository().unfollowPlace(placeId);
    if (placeUnFollowApiModel.status == 1) {
      emit(PlaceUnFollowState(placeUnFollowApiModel));
    } else {
      emit(PlaceUnFollowErrorState(placeUnFollowApiModel));
    }
  }
}
