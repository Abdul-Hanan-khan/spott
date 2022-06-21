// ignore_for_file: invalid_assignment

import 'package:spott/models/data_models/post.dart';

class ViewPostApiModel {
  ViewPostApiModel({
    int? status,
    String? message,
    Post? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ViewPostApiModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Post.fromJson(json['data']) : null;
  }
  int? _status;
  String? _message;
  Post? _data;

  int? get status => _status;
  String? get message => _message;
  Post? get data => _data;
}
