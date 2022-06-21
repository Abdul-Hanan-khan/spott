// ignore_for_file: invalid_assignment


import 'package:spott/models/data_models/post.dart';

class TopSportsPaginationModel {
  dynamic? _status;
  Top_spots? _topSpots;

  int? get status => _status;
  Top_spots? get topSpots => _topSpots;

  TopSportsPaginationModel({
      int? status, 
      Top_spots? topSpots}){
    _status = status;
    _topSpots = topSpots;
}

  TopSportsPaginationModel.fromJson(dynamic json) {
    _status = json['status'];
    _topSpots = json['top_spots'] != null ? Top_spots.fromJson(json['top_spots']) : null;
  }


}

class Top_spots {
  int? _currentPage;
  List<Post>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  String? _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic? _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<Post>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  int? get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  String? get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic? get prevPageUrl => _prevPageUrl;
  int? get to => _to;
  int? get total => _total;

  Top_spots({
      int? currentPage, 
      List<Post>? data,
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      String? nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic? prevPageUrl, 
      int? to, 
      int? total}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Top_spots.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Post.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }


}
