// ignore_for_file: invalid_assignment
import 'package:spott/models/data_models/post.dart';
import 'package:spott/models/data_models/user.dart';

enum SpotStatus { pending, accept, reject }

class Spot {
  int? _id;
  int? _refId;
  String? _type;
  int? _userId;
  SpotStatus? _status;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
  Post? _post;

  int? get id => _id;
  int? get refId => _refId;
  String? get type => _type;
  int? get userId => _userId;
  SpotStatus? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  User? get user => _user;
  Post? get post => _post;

  void requestAccepted() {
    _status = SpotStatus.accept;
  }

  void requestRejected() {
    _status = SpotStatus.reject;
  }

  Spot(
    int? id,
    int? refId,
    String? type,
    int? userId,
    SpotStatus? status,
    String? createdAt,
    String? updatedAt,
    User? user,
    Post? post,
  ) {
    _id = id;
    _refId = refId;
    _type = type;
    _userId = userId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _user = user;
    _post = post;
  }

  Spot.fromJson(dynamic json) {
    if (json != null) {
      _id = json['id'];
      _refId = json['ref_id'];
      _type = json['type'];
      _userId = json['user_id'];
      _status = json['status'] != null
          ? SpotStatus.values
              .firstWhere((e) => e.toString() == 'SpotStatus.${json['status']}')
          : null;
      _createdAt = json['created_at'];
      _updatedAt = json['updated_at'];
      _user = json['user'] != null ? User.fromJson(json['user']) : null;
      _post = json['ref'] != null ? Post.fromJson(json['ref']) : null;
    }
  }
}
