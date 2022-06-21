// ignore_for_file: invalid_assignment

class Report {
  int? _refId;
  String? _type;
  int? _userId;
  String? _reason;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  int? get refId => _refId;
  String? get type => _type;
  int? get userId => _userId;
  String? get reason => _reason;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Report(
      {int? refId,
      String? type,
      int? userId,
      String? reason,
      String? updatedAt,
      String? createdAt,
      int? id}) {
    _refId = refId;
    _type = type;
    _userId = userId;
    _reason = reason;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Report.fromJson(dynamic json) {
    _refId = json['ref_id'];
    _type = json['type'];
    _userId = json['user_id'];
    _reason = json['reason'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }
}
