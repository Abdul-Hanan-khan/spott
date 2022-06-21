// ignore_for_file: invalid_assignment
abstract class GeneralApiResponse {
  int? _status;
  String? _message;

  int? get status => _status;
  String? get message => _message;

  GeneralApiResponse({int? status, String? message}) {
    _status = status;
    _message = message;
  }

  GeneralApiResponse.fromJson(dynamic json) {
    if (json != null) {
      if (json is String) {
        _message = json;
      } else {
        _status = json["status"];
        _message = json["message"]?.toString();
      }
    }
  }
}
