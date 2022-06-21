import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:spott/models/api_responses/get_explore_api_response.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';
import 'package:spott/utils/helper_functions.dart';

part 'explore_screen_state.dart';

class ExploreScreenCubit extends Cubit<ExploreScreenState> {
  final Repository _repository = Repository();

  ExploreScreenCubit() : super(ExploreScreenInitial());

  Future<void> getInitialExploreData(BuildContext context) async {
    if (AppData.accessToken != null) {
      emit(FetchingData());
      _getExploreData(context, AppData.accessToken!);
    }
  }

  Future<void> refreshExploreData(BuildContext context) async {
    if (AppData.accessToken != null) {
      emit(RefreshingData());
      _getExploreData(context, AppData.accessToken!);
    }
  }

  Future<void> _getExploreData(BuildContext context, String accessToken) async {
    final userPosition = await getUserLatLng(context);

    if (userPosition != null) {
      final GetExploreApiResponse _apiResponse =
          await _repository.getExploreData(
        token: accessToken,
        lat: userPosition.latitude,
        lng: userPosition.longitude,
      );
      if (_apiResponse.status == ApiResponse.success) {
        emit(DataFetchedSuccessfully(_apiResponse));
      } else {
        emit(
          FailedToFetchData(
            _apiResponse.message ?? LocaleKeys.failedToGetExplore.tr(),
          ),
        );
      }
    } else {
      emit(
        GPSDisabled(),
      );
    }
  }
}
