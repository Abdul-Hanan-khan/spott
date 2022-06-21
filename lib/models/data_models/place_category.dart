// ignore_for_file: invalid_assignment
class PlaceCategory {
  int? _id;
  String? _name;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  PlaceCategory(
      {int? id,
      String? name,
      String? image,
      String? createdAt,
      String? updatedAt}) {
    _id = id;
    _name = name;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  PlaceCategory.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _image = json["image"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }
}
