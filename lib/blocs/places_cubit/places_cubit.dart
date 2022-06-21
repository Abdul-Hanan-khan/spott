import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:spott/models/api_responses/add_new_place_api_response.dart';
import 'package:spott/models/api_responses/get_place_categories_api_response.dart';
import 'package:spott/models/api_responses/get_place_suggestions_api_response.dart';
import 'package:spott/models/data_models/place.dart';
import 'package:spott/models/data_models/place_category.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/resources/repository.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/utils/constants/api_constants.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final Repository _repository = Repository();

  PlacesCubit() : super(PlacesInitial());

  Future<void> addNewPost({
    required double lat,
    required double lng,
    required String address,
    required String name,
    required int? categoryId,
    required List<Uint8List> images,
  }) async {
    if (AppData.accessToken != null) {
      emit(AddingNewPlace());

      final Map<String, dynamic> _map = {
        'name': name,
        'fullAddress': address,
        'lat': lat,
        'lng': lng,
        'category_id': categoryId,
      };
      for (int i = 0; i < images.length; i++) {
        _map.putIfAbsent(
          'images[$i]',
          () => MultipartFile.fromBytes(images[i], filename: 'image$i.png'),
        );
      }
      print("Post daata => ${_map}");
      final FormData _data = FormData.fromMap(_map);
      final AddNewPlaceApiResponse _apiResponse =
          await _repository.addNewPlace(AppData.accessToken!, _data);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.place != null) {
        emit(PlaceAddedSuccessfully(_apiResponse.place!));
      } else {
        emit(
          ErrorState(_apiResponse.message ?? LocaleKeys.placeAddFailed.tr()),
        );
      }
    }
  }

  Future<void> getPlaceCategories({
    required double lat,
    required double lng,
  }) async {
    if (AppData.accessToken != null) {
      emit(FetchingPlaceCategories());
      final GetPlaceCategoriesApiResponse _apiResponse = await _repository
          .getPlaceCategories(token: AppData.accessToken!, lat: lat, lng: lng);
      if (_apiResponse.status == ApiResponse.success &&
          _apiResponse.categories != null) {
        emit(
          PlaceCategoriesFetchedSuccessfully(_apiResponse.categories!),
        );
      } else {
        emit(
          ErrorState(
            _apiResponse.message ?? LocaleKeys.getPlaceCategoriesFailed.tr(),
          ),
        );
      }
    }
  }

  Future<void> getPlaceSuggestions({
    required double lat,
    required double lng,
  }) async {
    if (AppData.accessToken != null) {
      emit(FetchingPlaceSuggestions());
      final GetPlaceSuggestionsApiResponse _apiResponse = await _repository
          .getPlaceSuggestions(token: AppData.accessToken!, lat: lat, lng: lng);
      if (_apiResponse.status == ApiResponse.success) {
        emit(
          PlaceSuggestionsFetchedSuccessfully(_apiResponse),
        );
      } else {
        emit(
          ErrorState(
            _apiResponse.message ?? LocaleKeys.getPlaceSuggestionFailed.tr(),
          ),
        );
      }
    }
  }
}
