import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiConstants {
  ApiConstants._();
  static const String baseUrl = "https://app.spottat.com";
  static const String loginUrl = "/api/auth/login";
  static const String signUpUrl = "/api/auth/register";
  static const String getUserProfileUrl = "/api/auth/user";
  static const String editUserProfileUrl = "/api/auth/user/edit";
  static const String addPostUrl = "/api/posts/store";
  static const String getPlaceSuggestionUrl = "/api/place/suggestion";
  static const String getPlaceCategoriesUrl = '/api/place/category';
  static const String getAllPostsUrl = "/api/posts";
  static const String likePostUrl = "/api/posts/like";
  static const String dislikePostUrl = "/api/posts/dislike";
  static const String createStoryUrl = "/api/storyPost";
  static const String getAllStoriesUrl = "/api/storyPost/all";
  static const String sendResetPasswordEmailUrl = "/api/auth/login/reset";
  static const String checkConfirmationCOdeUrl =
      "/api/auth/login/reset/confirm";
  static const String updatePasswordUrl = "/api/auth/login/reset/password";
  static String getCommentUrl(String _postId) => "/api/posts/$_postId/comment";
  static String getPostInteractionsUrl(String _postId) =>
      "/api/posts/$_postId/likeOrDislike";
  static String getPostDislikeUrl(String _postId) =>
      "/api/posts/$_postId/dislike";
  static const String addCommentUrl = "/api/posts/comment";
  static const String signInWithGoogleUrl = "/api/auth/google-login";
  static const String addNewPlaceUrl = "/api/place";
  static const String getPlaceDetailUrl = "/api/place/details";
  static const String requestSpottUrl = "/api/spot/request";
  static const String getAllSpottRequestsUrl = '/api/post/spot-requests';
  static const String getNotificationsUrl = "/api/user/notifications";
  static const String updateNotificationTokenUrl =
      "/api/user/set-notification-token";
  static const String viewUserProfileUrl = "/api/user/profile/";
  static const String getUserPreferencesUrl = "/api/user/preferences";
  static const String updateUserPreferencesUrl = "/api/user/preferences/update";
  static const String logoutUrl = "/api/auth/logout";
  static const String exploreUrl = "/api/user/explore";
  static const String followUserUrl = "/api/user/follow";
  static const String unFollowUserUrl = "/api/user/un-follow";
  static const String markNotificationsReadUrl =
      "/api/user/update-notifications-status";
  static const String acceptSpotRequestUrl = "/api/spot/accept";
  static const String rejectSpotRequestUrl = "/api/spot/delete";
  static const String followRequestUrl =
      "/api/user/follow/change-request-status";
  static const String searchApiUrl = "/api/user/explore/search";
  static const String changePasswordApiUrl = "/api/auth/update-password";
  static const String blockUserApiUrl = "/api/user/block";
  static const String getBlockedUsersApiUrl = "/api/user/blocked/list";
  static const String unblockUserApiUrl = '/api/user/un-block';
  static const String markStoryAsReadApiUrl = '/api/storyPost/seen';
  static const String userSpottedPostsUrl = '/api/user/spot-posts';
  static const String userFollowersUrl = '/api/user/followers';
  static const String userFollowingUrl = '/api/user/following';
  static const String reportContentUrl = '/api/report-content';
  static const String requestStorySpottUrl = '/api/storyPost/spot/request/add';
  static const String getUserProfileShareLink = '/api/share/user';
  static const String getPlaceProfileShareLink = '/api/share/place';

  static const String postAddRating = '/api/place/ratings/add';

  static const String postGetAllRating = '/api/place/ratings/all';

  static const String sendNotification = '/api/user/send-message-notification';

  static const String spottedListViewApi = '/api/place/spotted-users';

  static const String socialLogApi = '/api/auth/social-login';

  static const String reactPostApi = '/api/posts/react';

  static const String reactsGetApi = '/api/posts/get-reacts';

  static const String placeFollowApi = '/api/place/follow';

  static const String placeUnFollowApi = '/api/place/un-follow';

  static const String topSportsApi = '/api/user/explore-spots';

  static const String topPlacesApi = '/api/user/explore-places';

  static const String postViewApi = '/api/posts/';

  static const String deletePostApi = '/api/posts/delete/';

  static const String deleteCommentApi = "/api/posts/comment/delete";

  static const String userStoryPostsApi = '$baseUrl/api/storyPost/user/';
  static const String allPlacePostsApi = '$baseUrl/api/place/all-post/';
  static const String spottedPostApi = '$baseUrl/api/place/spotted-posts';
  static const String placeAllStoryApi = '$baseUrl/api/place/all-stories/';
  static const String postSeen = '$baseUrl/api/posts/seen';

  static header(String token, Dio dio) {
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers['Language'] = GetStorage().read('Language') ?? 'en';
  }
}

class ApiResponse {
  static const success = 1;
  static const failed = 0;
}
