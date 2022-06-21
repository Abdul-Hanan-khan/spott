// ignore_for_file: invalid_assignment
import 'package:spott/models/api_responses/general_api_response.dart';
import 'package:spott/models/data_models/post_interaction.dart';

class GetPostInteractionApiResponse extends GeneralApiResponse {
  Data? _data;

  Data? get data => _data;

  GetPostInteractionApiResponse({int? status, String? message, Data? data})
      : super(status: status, message: message) {
    _data = data;
  }

  GetPostInteractionApiResponse.fromJson(dynamic json) : super.fromJson(json) {
    if (json != null) {
      _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    }
  }
}

class Data {
  int? _totalLikes;
  int? _totalDislikes;
  List<PostInteraction>? _dataLikes;
  List<PostInteraction>? _dataDislikes;

  int? get totalLikes => _totalLikes;
  int? get totalDislikes => _totalDislikes;
  List<PostInteraction>? get dataLikes => _dataLikes;
  List<PostInteraction>? get dataDislikes => _dataDislikes;

  Data(
      {int? totalLikes,
      int? totalDislikes,
      List<PostInteraction>? dataLikes,
      List<PostInteraction>? dataDislikes}) {
    _totalLikes = totalLikes;
    _totalDislikes = totalDislikes;
    _dataLikes = dataLikes;
    _dataDislikes = dataDislikes;
  }

  Data.fromJson(dynamic json) {
    _totalLikes = json["total_likes"];
    _totalDislikes = json["total_dislikes"];
    if (json["data_likes"] != null) {
      _dataLikes = [];
      json["data_likes"].forEach((v) {
        _dataLikes?.add(PostInteraction.fromJson(v));
      });
    }
    if (json["data_dislikes"] != null) {
      _dataDislikes = [];
      json["data_dislikes"].forEach((v) {
        _dataDislikes?.add(PostInteraction.fromJson(v));
      });
    }
  }
}
