// ignore_for_file: invalid_assignment
// ignore_for_file:argument_type_not_assignable

import 'package:collection/collection.dart';
import 'package:spott/models/data_models/user.dart';

import 'follow.dart';
import 'post.dart';

class AppNotification {
  int? _id;
  int? _userId;
  User? _refUser;
  AppNotificationStatus? _status;
  String? _content;
  AppNotificationType? _type;
  ModelType? _modelType;
  int? _refModelId;
  Post? _post;
  Follow? _follow;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  AppNotification(
      {int? id,
      int? userId,
      User? refUser,
      AppNotificationStatus? status,
      String? content,
      AppNotificationType? type,
      ModelType? modeType,
      int? refModelId,
      Post? post,
      Follow? follow,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    _id = id;
    _userId = userId;
    _refUser = refUser;
    _status = status;
    _content = content;
    _type = type;
    _modelType = modeType;
    _refModelId = refModelId;
    _post = post;
    _follow = follow;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }
  AppNotification.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _refUser =
        json["ref_user"] != null ? User.fromJson(json["ref_user"]) : null;
    _status = json["status"] != null
        ? AppNotificationStatus.values.firstWhere(
            (e) => e.toString() == 'AppNotificationStatus.${json["status"]}')
        : null;
    _content = json["content"];
    _type = json["type"] != null
        ? AppNotificationType.values.firstWhere(
            (e) => e.toString() == 'AppNotificationType.${json["type"]}')
        : null;
    _modelType = json["model"] != null
        ? ModelType.values.firstWhereOrNull(
            (element) => element.toString() == 'ModelType.${json["model"]}')
        : null;
    _refModelId = json["ref_model_id"];
    getModelData(json["model_data"]);
    _createdAt =
        json["created_at"] != null ? DateTime.parse(json["created_at"]) : null;
    _updatedAt =
        json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null;
  }
  String? get content => _content;
  DateTime? get createdAt => _createdAt;
  Follow? get follow => _follow;
  int? get id => _id;
  ModelType? get modelType => _modelType;
  Post? get post => _post;
  int? get refModelId => _refModelId;
  User? get refUser => _refUser;
  AppNotificationStatus? get status => _status;
  AppNotificationType? get type => _type;

  DateTime? get updatedAt => _updatedAt;

  int? get userId => _userId;

  void getModelData(dynamic json) {
    switch (_modelType) {
      case ModelType.comment:
        _post = Post.fromJson(json);
        break;
      case ModelType.post:
        _post = Post.fromJson(json);
        break;
      case ModelType.spot:
        _post = Post.fromJson(json);
        break;
      case ModelType.follow:
        _follow = Follow.fromJson(json);
        break;
      default:
    }
  }

  void markNotificationRead() {
    _status = AppNotificationStatus.read;
  }
}

enum AppNotificationStatus { read, unread }

enum AppNotificationType { you, nearby }

enum ModelType { comment, spot, follow, post }
