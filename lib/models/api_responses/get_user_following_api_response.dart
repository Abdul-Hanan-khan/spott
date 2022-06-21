import 'package:spott/models/data_models/follow.dart';

import 'general_api_response.dart';

class GetUserFollowingApiResponse extends GeneralApiResponse{
  List<Follow>? _followers;

  List<Follow>? get followers => _followers;

  GetUserFollowingApiResponse({
      int? status, 
      String? message,
      List<Follow>? followers}): super (status: status,message: message) {
    _followers = followers;
}

  GetUserFollowingApiResponse.fromJson(dynamic json) :super.fromJson(json) {
    if(json!=null){
    if (json['following'] != null) {
      _followers = [];
      json['following'].forEach((v) {
        _followers?.add(Follow.fromJson(v));
      });
    }
    }
  }
}