import 'package:dio/dio.dart';
import 'package:spott/models/api_responses/add_new_place_api_response.dart';
import 'package:spott/models/api_responses/get_place_categories_api_response.dart';
import 'package:spott/models/api_responses/get_place_detail_api_response.dart';
import 'package:spott/models/api_responses/get_place_suggestions_api_response.dart';
import 'package:spott/models/api_responses/place_stories_api_response.dart';
import 'package:spott/utils/constants/api_constants.dart';

class PlaceApiProvider {
  Future<GetPlaceSuggestionsApiResponse> getPlaceSuggestions(
      {required String token, required double lat, required double lng}) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.getPlaceSuggestionUrl,
          data: FormData.fromMap({
            'lat': lat,
            'lng': lng,
          }));
      if (response.statusCode == 200) {
        return GetPlaceSuggestionsApiResponse.fromJson(response.data);
      } else {
        return GetPlaceSuggestionsApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetPlaceSuggestionsApiResponse.fromJson(e.response?.data);
      } else {
        return GetPlaceSuggestionsApiResponse(message: e.toString());
      }
    }
  }

  Future<GetPlaceCategoriesApiResponse> getPlaceCategories(
      {required String token, required double lat, required double lng}) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(token, dio);
      final Response response = await dio.get(
        ApiConstants.baseUrl + ApiConstants.getPlaceCategoriesUrl,
      );
      if (response.statusCode == 200) {
        return GetPlaceCategoriesApiResponse.fromJson(response.data);
      } else {
        return GetPlaceCategoriesApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetPlaceCategoriesApiResponse.fromJson(e.response?.data);
      } else {
        return GetPlaceCategoriesApiResponse(message: e.toString());
      }
    }
  }

  Future<AddNewPlaceApiResponse> addNewPlace(
      String _token, FormData _data) async {
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.addNewPlaceUrl,
          data: _data);
      if (response.statusCode == 200) {
        print("Place added => ${response.data}");
        return AddNewPlaceApiResponse.fromJson(response.data);
      } else {
        return AddNewPlaceApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return AddNewPlaceApiResponse.fromJson(e.response?.data);
      } else {
        return AddNewPlaceApiResponse(message: e.toString());
      }
    }
  }

  Future<GetPlaceDetailApiResponse> getPlaceDetail(
      String _token, String _placeId) async {
    print('$_placeId');
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.post(
          ApiConstants.baseUrl + ApiConstants.getPlaceDetailUrl,
          data: FormData.fromMap({'place_id': _placeId}));
      if (response.statusCode == 200) {
        return GetPlaceDetailApiResponse.fromJson(response.data);
      } else {
        return GetPlaceDetailApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        return GetPlaceDetailApiResponse.fromJson(e.response?.data);
      } else {
        return GetPlaceDetailApiResponse(message: e.toString());
      }
    }
  }


  Future<PlaceStoriesApiResponse> placeAllStory(
      String _token, String _placeId) async {
    print('$_placeId');
    try {
      final Dio dio = Dio();
      ApiConstants.header(_token, dio);
      final Response response = await dio.get(ApiConstants.placeAllStoryApi + _placeId);
      if (response.statusCode == 200) {
        return PlaceStoriesApiResponse.fromJson(response.data);
      } else {
        return PlaceStoriesApiResponse(message: response.toString());
      }
    } catch (e) {
      if (e is DioError) {
        print("\n\n\n\n");
        print(e.response?.data);
        print("\n\n\n\n");
        return PlaceStoriesApiResponse.fromJson(e.response?.data);
      } else {
        return PlaceStoriesApiResponse(message: e.toString());
      }
    }
  }
}
