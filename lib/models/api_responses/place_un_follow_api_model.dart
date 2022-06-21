/// message : "place un-followed"
/// status : 1

class PlaceUnFollowApiModel {
  dynamic _message;
  dynamic _status;

  dynamic get message => _message;
  dynamic get status => _status;

  PlaceUnFollowApiModel({dynamic message, dynamic status}) {
    _message = message;
    _status = status;
  }

  PlaceUnFollowApiModel.fromJson(dynamic json) {
    _message = json['message'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    return map;
  }
}
