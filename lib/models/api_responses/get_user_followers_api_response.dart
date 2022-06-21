import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/follow.dart';

class GetUserFollowersApiResponse extends GeneralApiResponse{
  List<Follow>? _followers;

  List<Follow>? get followers => _followers;

  GetUserFollowersApiResponse({
      int? status, 
      String? message,
      List<Follow>? followers}): super (status: status,message: message) {
    _followers = followers;
}

  GetUserFollowersApiResponse.fromJson(dynamic json) :super.fromJson(json) {
    if(json!=null){
    if (json['followers'] != null) {
      _followers = [];
      json['followers'].forEach((v) {
        _followers?.add(Follow.fromJson(v));
      });
    }
    }
  }
}