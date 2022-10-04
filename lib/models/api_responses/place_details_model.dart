// // To parse this JSON data, do
// //
// //     final place = placeFromJson(jsonString);
//
// import 'dart:convert';
//
// Place placeFromJson(String str) => Place.fromJson(json.decode(str));
//
// String placeToJson(Place data) => json.encode(data.toJson());
//
// class Place {
//   Place({
//     this.message,
//     this.status,
//     this.place,
//   });
//
//   String message;
//   int status;
//   PlaceClass place;
//
//   factory Place.fromJson(Map<String, dynamic> json) => Place(
//     message: json["message"],
//     status: json["status"],
//     place: PlaceClass.fromJson(json["place"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "status": status,
//     "place": place.toJson(),
//   };
// }
//
// class Post {
//   Post({
//     this.id,
//     this.userId,
//     this.type,
//     this.content,
//     this.lat,
//     this.lng,
//     this.address,
//     this.placeId,
//     this.placeType,
//     this.status,
//     this.privacy,
//     this.media,
//     this.views,
//     this.createdAt,
//     this.updatedAt,
//     this.likesCount,
//     this.dislikesCount,
//     this.reactsCount,
//     this.commentsCount,
//     this.userCommentCount,
//     this.totalCount,
//     this.user,
//     this.spot,
//     this.place,
//     this.reacts,
//     this.isReacted,
//   });
//
//   int id;
//   int userId;
//   String type;
//   String content;
//   double lat;
//   double lng;
//   String address;
//   String placeId;
//   String placeType;
//   int status;
//   String privacy;
//   List<String> media;
//   int views;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int likesCount;
//   int dislikesCount;
//   int reactsCount;
//   int commentsCount;
//   int userCommentCount;
//   int totalCount;
//   User user;
//   dynamic spot;
//   PlaceClass place;
//   List<dynamic> reacts;
//   dynamic isReacted;
//
//   factory Post.fromJson(Map<String, dynamic> json) => Post(
//     id: json["id"],
//     userId: json["user_id"],
//     type: json["type"],
//     content: json["content"],
//     lat: json["lat"].toDouble(),
//     lng: json["lng"].toDouble(),
//     address: json["address"],
//     placeId: json["place_id"],
//     placeType: json["place_type"],
//     status: json["status"],
//     privacy: json["privacy"],
//     media: List<String>.from(json["media"].map((x) => x)),
//     views: json["views"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     likesCount: json["likes_count"],
//     dislikesCount: json["dislikes_count"],
//     reactsCount: json["reacts_count"],
//     commentsCount: json["comments_count"],
//     userCommentCount: json["user_comment_count"],
//     totalCount: json["total_count"],
//     user: User.fromJson(json["user"]),
//     spot: json["spot"],
//     place: PlaceClass.fromJson(json["place"]),
//     reacts: List<dynamic>.from(json["reacts"].map((x) => x)),
//     isReacted: json["is_reacted"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "type": type,
//     "content": content,
//     "lat": lat,
//     "lng": lng,
//     "address": address,
//     "place_id": placeId,
//     "place_type": placeType,
//     "status": status,
//     "privacy": privacy,
//     "media": List<dynamic>.from(media.map((x) => x)),
//     "views": views,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "likes_count": likesCount,
//     "dislikes_count": dislikesCount,
//     "reacts_count": reactsCount,
//     "comments_count": commentsCount,
//     "user_comment_count": userCommentCount,
//     "total_count": totalCount,
//     "user": user.toJson(),
//     "spot": spot,
//     "place": place.toJson(),
//     "reacts": List<dynamic>.from(reacts.map((x) => x)),
//     "is_reacted": isReacted,
//   };
// }
//
// class PlaceClass {
//   PlaceClass({
//     this.id,
//     this.refId,
//     this.refType,
//     this.name,
//     this.hashtags,
//     this.details,
//     this.lat,
//     this.lng,
//     this.fullAddress,
//     this.images,
//     this.mainPicture,
//     this.coverPicture,
//     this.userId,
//     this.categoryId,
//     this.createdAt,
//     this.updatedAt,
//     this.isFollowingCount,
//     this.reactsCount,
//     this.groupStories,
//     this.averageRating,
//     this.followCount,
//     this.spotCount,
//     this.isReacted,
//     this.reacts,
//     this.isFollower,
//     this.ratings,
//     this.posts,
//     this.followers,
//   });
//
//   int id;
//   dynamic refId;
//   dynamic refType;
//   String name;
//   dynamic hashtags;
//   dynamic details;
//   double lat;
//   double lng;
//   String fullAddress;
//   List<String> images;
//   dynamic mainPicture;
//   dynamic coverPicture;
//   int userId;
//   int categoryId;
//   String createdAt;
//   DateTime updatedAt;
//   int isFollowingCount;
//   int reactsCount;
//   List<List<GroupStory>> groupStories;
//   int averageRating;
//   int followCount;
//   int spotCount;
//   dynamic isReacted;
//   List<dynamic> reacts;
//   dynamic isFollower;
//   List<dynamic> ratings;
//   List<Post> posts;
//   List<dynamic> followers;
//
//   factory PlaceClass.fromJson(Map<String, dynamic> json) => PlaceClass(
//     id: json["id"],
//     refId: json["ref_id"],
//     refType: json["ref_type"],
//     name: json["name"],
//     hashtags: json["hashtags"],
//     details: json["details"],
//     lat: json["lat"].toDouble(),
//     lng: json["lng"].toDouble(),
//     fullAddress: json["fullAddress"],
//     images: List<String>.from(json["images"].map((x) => x)),
//     mainPicture: json["main_picture"],
//     coverPicture: json["cover_picture"],
//     userId: json["user_id"],
//     categoryId: json["category_id"],
//     createdAt: json["created_at"],
//     updatedAt: DateTime.parse(json["updated_at"]),
//     isFollowingCount: json["is_following_count"],
//     reactsCount: json["reacts_count"],
//     groupStories: json["group_stories"] == null ? null :
//     List<List<GroupStory>>.from(json["group_stories"].map((x)
//     => List<GroupStory>.from(x.map((x) => GroupStory.fromJson(x))))),
//     averageRating: json["average-rating"],
//     followCount: json["follow-count"],
//     spotCount: json["spot-count"],
//     isReacted: json["is_reacted"],
//     reacts: List<dynamic>.from(json["reacts"].map((x) => x)),
//     isFollower: json["is_follower"],
//     ratings: json["ratings"] == null ? null : List<dynamic>.from(json["ratings"].map((x) => x)),
//     posts: json["posts"] == null ? null : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//     followers: List<dynamic>.from(json["followers"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "ref_id": refId,
//     "ref_type": refType,
//     "name": name,
//     "hashtags": hashtags,
//     "details": details,
//     "lat": lat,
//     "lng": lng,
//     "fullAddress": fullAddress,
//     "images": List<dynamic>.from(images.map((x) => x)),
//     "main_picture": mainPicture,
//     "cover_picture": coverPicture,
//     "user_id": userId,
//     "category_id": categoryId,
//     "created_at": createdAt,
//     "updated_at": updatedAt.toIso8601String(),
//     "is_following_count": isFollowingCount,
//     "reacts_count": reactsCount,
//     "group_stories": groupStories == null ? null : List<dynamic>.from(groupStories.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
//     "average-rating": averageRating,
//     "follow-count": followCount,
//     "spot-count": spotCount,
//     "is_reacted": isReacted,
//     "reacts": List<dynamic>.from(reacts.map((x) => x)),
//     "is_follower": isFollower,
//     "ratings": ratings == null ? null : List<dynamic>.from(ratings.map((x) => x)),
//     "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
//     "followers": List<dynamic>.from(followers.map((x) => x)),
//   };
// }
//
// class User {
//   User({
//     this.id,
//     this.name,
//     this.username,
//     this.email,
//     this.phone,
//     this.country,
//     this.bio,
//     this.city,
//     this.address,
//     this.lat,
//     this.lng,
//     this.emailVerifiedAt,
//     this.resetCode,
//     this.type,
//     this.socialLogin,
//     this.isActive,
//     this.isBlocked,
//     this.expiryDate,
//     this.profilePicture,
//     this.coverPicture,
//     this.rights,
//     this.createdBy,
//     this.createdAt,
//     this.updatedAt,
//     this.notificationToken,
//     this.followersCount,
//     this.followingCount,
//     this.spotsCount,
//     this.placesCount,
//     this.isFollower,
//   });
//
//   int id;
//   String name;
//   String username;
//   String email;
//   dynamic phone;
//   dynamic country;
//   dynamic bio;
//   dynamic city;
//   dynamic address;
//   double lat;
//   double lng;
//   dynamic emailVerifiedAt;
//   dynamic resetCode;
//   String type;
//   dynamic socialLogin;
//   int isActive;
//   int isBlocked;
//   dynamic expiryDate;
//   dynamic profilePicture;
//   dynamic coverPicture;
//   dynamic rights;
//   dynamic createdBy;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String notificationToken;
//   int followersCount;
//   int followingCount;
//   int spotsCount;
//   int placesCount;
//   dynamic isFollower;
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     name: json["name"] == null ? null : json["name"],
//     username: json["username"],
//     email: json["email"],
//     phone: json["phone"],
//     country: json["country"],
//     bio: json["bio"],
//     city: json["city"],
//     address: json["address"],
//     lat: json["lat"] == null ? null : json["lat"].toDouble(),
//     lng: json["lng"] == null ? null : json["lng"].toDouble(),
//     emailVerifiedAt: json["email_verified_at"],
//     resetCode: json["reset_code"],
//     type: json["type"],
//     socialLogin: json["social_login"],
//     isActive: json["isActive"],
//     isBlocked: json["isBlocked"],
//     expiryDate: json["expiry_date"],
//     profilePicture: json["profile_picture"],
//     coverPicture: json["cover_picture"],
//     rights: json["rights"],
//     createdBy: json["created_by"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     notificationToken: json["notification_token"],
//     followersCount: json["followers_count"],
//     followingCount: json["following_count"],
//     spotsCount: json["spots_count"],
//     placesCount: json["places_count"],
//     isFollower: json["is_follower"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name == null ? null : name,
//     "username": username,
//     "email": email,
//     "phone": phone,
//     "country": country,
//     "bio": bio,
//     "city": city,
//     "address": address,
//     "lat": lat == null ? null : lat,
//     "lng": lng == null ? null : lng,
//     "email_verified_at": emailVerifiedAt,
//     "reset_code": resetCode,
//     "type": type,
//     "social_login": socialLogin,
//     "isActive": isActive,
//     "isBlocked": isBlocked,
//     "expiry_date": expiryDate,
//     "profile_picture": profilePicture,
//     "cover_picture": coverPicture,
//     "rights": rights,
//     "created_by": createdBy,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "notification_token": notificationToken,
//     "followers_count": followersCount,
//     "following_count": followingCount,
//     "spots_count": spotsCount,
//     "places_count": placesCount,
//     "is_follower": isFollower,
//   };
// }
//
// class GroupStory {
//   GroupStory({
//     this.id,
//     this.userId,
//     this.type,
//     this.content,
//     this.lat,
//     this.lng,
//     this.address,
//     this.placeId,
//     this.placeType,
//     this.status,
//     this.privacy,
//     this.media,
//     this.views,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//     this.spot,
//   });
//
//   int id;
//   int userId;
//   String type;
//   String content;
//   double lat;
//   double lng;
//   String address;
//   String placeId;
//   String placeType;
//   int status;
//   String privacy;
//   List<String> media;
//   int views;
//   DateTime createdAt;
//   DateTime updatedAt;
//   User user;
//   Spot spot;
//
//   factory GroupStory.fromJson(Map<String, dynamic> json) => GroupStory(
//     id: json["id"],
//     userId: json["user_id"],
//     type: json["type"],
//     content: json["content"],
//     lat: json["lat"].toDouble(),
//     lng: json["lng"].toDouble(),
//     address: json["address"],
//     placeId: json["place_id"],
//     placeType: json["place_type"],
//     status: json["status"],
//     privacy: json["privacy"],
//     media: List<String>.from(json["media"].map((x) => x)),
//     views: json["views"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     user: User.fromJson(json["user"]),
//     spot: json["spot"] == null ? null : Spot.fromJson(json["spot"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "user_id": userId,
//     "type": type,
//     "content": content,
//     "lat": lat,
//     "lng": lng,
//     "address": address,
//     "place_id": placeId,
//     "place_type": placeType,
//     "status": status,
//     "privacy": privacy,
//     "media": List<dynamic>.from(media.map((x) => x)),
//     "views": views,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "user": user.toJson(),
//     "spot": spot == null ? null : spot.toJson(),
//   };
// }
//
// class Spot {
//   Spot({
//     this.id,
//     this.refId,
//     this.type,
//     this.userId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//   });
//
//   int id;
//   int refId;
//   String type;
//   int userId;
//   String status;
//   DateTime createdAt;
//   DateTime updatedAt;
//   User user;
//
//   factory Spot.fromJson(Map<String, dynamic> json) => Spot(
//     id: json["id"],
//     refId: json["ref_id"],
//     type: json["type"],
//     userId: json["user_id"],
//     status: json["status"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     user: User.fromJson(json["user"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "ref_id": refId,
//     "type": type,
//     "user_id": userId,
//     "status": status,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "user": user.toJson(),
//   };
// }
