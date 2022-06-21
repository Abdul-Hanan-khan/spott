import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spott/models/api_responses/top_places_pagination_model.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/helper_functions.dart';
import 'package:spott/utils/show_snack_bar.dart';
import 'package:spott/variables.dart';

part 'top_places_state.dart';

List<Place> allPlaces = [];

class TopPlacesCubit extends Cubit<TopPlacesState> {
  TopPlacesCubit() : super(TopPlacesInitial());

  List<Place> get places => allPlaces;

  Future<void> getInitialExploreData(BuildContext context) async {
    if (AppData.accessToken != null) {
      emit(TopPlacesFetchingData());
      getTopPlaces(context, AppData.accessToken!, true);
    }
  }

  Future<void> refreshExploreData(BuildContext context) async {
    allPlaces = [];
    if (AppData.accessToken != null) {
      emit(TopPlacesRefreshingData());
      getTopPlaces(context, AppData.accessToken!, true);
    }
  }

  Future<void> getTopPlaces(
      BuildContext context, String accessToken, bool isFirstTimeLoading) async {
    final userPosition = await getUserLatLng(context);
    emit(TopPlacesFetchingData());

    if (userPosition != null) {
      if (isFirstTimeLoading) {
        final TopPlacesPaginationModel _apiResponse =
            await Repository().getTopPlaces(
          token: accessToken,
          lat: userPosition.latitude,
          lng: userPosition.longitude,
          nextPageUrl: null,
        );

        if (_apiResponse.status == 1) {
          nextPageUrlPlaces = _apiResponse.topPlaces?.nextPageUrl;
          print("next page url 1 => ${nextPageUrlPlaces}");
          actionOnResponse(_apiResponse);
        }
      } else if (nextPageUrlPlaces != null) {
        final TopPlacesPaginationModel _apiResponse =
            await Repository().getTopPlaces(
          token: accessToken,
          lat: userPosition.latitude,
          lng: userPosition.longitude,
          nextPageUrl: nextPageUrlPlaces,
        );

        if (_apiResponse.status == 1) {
          nextPageUrlPlaces = _apiResponse.topPlaces?.nextPageUrl;
          print("next page url 2 => ${nextPageUrlPlaces}");
          actionOnResponse(_apiResponse);
        }
      } else {
        print("Data is not available");
        emit(TopPlacesDataFetchedSuccessfully());
      }
    } else {
      emit(
        TopPlacesGPSDisabled(),
      );
    }
  }

  actionOnResponse(TopPlacesPaginationModel _apiResponse) {
    print("Top spots status => ${_apiResponse.status}");
    if (_apiResponse.status == ApiResponse.success) {
      print("length ${allPlaces.length}");
      allPlaces.addAll(_apiResponse.topPlaces!.data!);
      print("length ${allPlaces.length}");
      emit(TopPlacesDataFetchedSuccessfully());
    } else {
      emit(
        TopPlacesFailedToFetchData(
          LocaleKeys.failedToGetExplore.tr(),
        ),
      );
    }
  }
}
