import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:spott/resources/api_providers/spot_request_accept_model.dart';
import 'package:spott/utils/constants/api_constants.dart';

class UpdateSpotRequestStatusApiRequestApiProvider {
  Future<SpotRequestAcceptModel> acceptSpotRequest(
    dynamic _token,
    dynamic _spotId,
  ) async {
    print("Spot parameters $_spotId");
    try {
      final http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.acceptSpotRequestUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $_token",
          'Language':GetStorage().read('Language')??'en'
        },
        body: {
          'spot_id': _spotId,
        },
      );

      if (response.statusCode == 200) {
        print('spot accept 1 => ${response.body}');

        return SpotRequestAcceptModel.fromJson(json.decode(response.body));
      } else {
        print('spot accept 2 ${response.statusCode} => ${response.body}');

        return SpotRequestAcceptModel(
            message: json.decode(response.body)['message'].toString());
      }
    } catch (error) {
      print('spot error 2 => ${error.toString()}');
      return SpotRequestAcceptModel(message: error.toString());
    }
  }

  Future<SpotRequestAcceptModel> rejectSpotRequest(
      dynamic _token, dynamic _spotId) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.rejectSpotRequestUrl),
        body: {
          'spot_id': _spotId.toString(),
        },
        headers: {
          'Accept': "Application/json",
          'Authorization': "Bearer $_token",
          'Language':GetStorage().read('Language')??'en'
        },
      );

      if (response.statusCode == 200) {
        print('spot reject response 1 => ${response.body}');
        return SpotRequestAcceptModel.fromJson(
          json.decode(response.body),
        );
      } else {
        print('spot reject response 2 => ${response.body}');
        return SpotRequestAcceptModel(
          message: json.decode(response.body)['message'].toString(),
        );
      }
    } catch (e) {
      print('Spot reject error => ${e.toString()}');
      return SpotRequestAcceptModel(message: e.toString());
    }
  }
}
