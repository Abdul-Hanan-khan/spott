import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/api_responses/top_sports_pagination_model.dart';
import 'package:spott/models/data_models/post.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import '../../../../variables.dart';

part 'top_sports_state.dart';

List<Post> allPosts = [];

class TopSpotsCubit extends Cubit<TopSpotsState> {
  TopSpotsCubit() : super(TopSpotsInitial());

  List<Post> get posts => allPosts;

  Future<void> getInitialExploreData(BuildContext context) async {
    if (AppData.accessToken != null) {
      emit(TopSpotsFetchingData());
      getTopSpots(context, AppData.accessToken!, true);
    }
  }

  Future<void> refreshExploreData(BuildContext context) async {
    allPosts = [];
    if (AppData.accessToken != null) {
      emit(TopSpotsFetchingData());
      getTopSpots(context, AppData.accessToken!, true);
    }
  }

  Future<void> getTopSpots(
      BuildContext context, String accessToken, bool isFirstTimeLoading) async {
    emit(TopSpotsFetchingData());

    final userPosition = await getUserLatLng(context);
    if (userPosition != null) {
      if (isFirstTimeLoading) {
        allPosts = [];
        final TopSportsPaginationModel _apiResponse =
            await Repository().getTopSpots(
          token: accessToken,
          lat: userPosition.latitude,
          lng: userPosition.longitude,
        );
        if (_apiResponse.status == 1) {
          nextPageUrlSpots = _apiResponse.topSpots?.nextPageUrl;
          actOnResponse(_apiResponse);
        } else {
          emit(
            TopSpotsFailedToFetchData(
              LocaleKeys.failedToGetExplore.tr(),
            ),
          );
        }
      } else if (nextPageUrlSpots != null) {
        final TopSportsPaginationModel _apiResponse = await Repository()
            .getTopSpots(
                token: accessToken,
                lat: userPosition.latitude,
                lng: userPosition.longitude,
                nextPageUrlPlaces: nextPageUrlSpots);
        if (_apiResponse.status == 1) {
          nextPageUrlSpots = _apiResponse.topSpots?.nextPageUrl;
          actOnResponse(_apiResponse);
        } else {
          emit(TopSpotsFailedToFetchData(
            LocaleKeys.failedToGetExplore.tr(),
          ));
        }
      } else {
        print("Data is not available");
        emit(TopSpotsDataFetchedSuccessfully());
        // showSnackBar(context: context, message: 'No more posts available');
      }
    } else {
      emit(
        TopSpotsGPSDisabled(),
      );
    }
  }

  actOnResponse(TopSportsPaginationModel _apiResponse) {
    print("Post length before ${allPosts.length}");
    if (_apiResponse.status == ApiResponse.success) {
      allPosts.addAll(_apiResponse.topSpots!.data!);
      print("Post length after ${allPosts.length}");

      emit(const TopSpotsDataFetchedSuccessfully());
      emit(const TopSpotsDataFetchedSuccessfully());
    } else {
      emit(
        TopSpotsFailedToFetchData(
          LocaleKeys.failedToGetExplore.tr(),
        ),
      );
    }
  }
}
