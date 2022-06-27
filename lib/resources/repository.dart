import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spott/models/api_responses/add_comment_api_response.dart';
import 'package:spott/models/api_responses/add_new_place_api_response.dart';
import 'package:spott/models/api_responses/add_post_api_response.dart';
import 'package:spott/models/api_responses/add_rating_response_model.dart';
import 'package:spott/models/api_responses/all_place_posts_api_response.dart';
import 'package:spott/models/api_responses/all_posts_pagination_model.dart';
import 'package:spott/models/api_responses/all_rating_api_response_model.dart';
import 'package:spott/models/api_responses/block_user_api_response.dart';
import 'package:spott/models/api_responses/change_password_api_response.dart';
import 'package:spott/models/api_responses/check_confirmation_code_api_response.dart';
import 'package:spott/models/api_responses/create_story_api_response.dart';
import 'package:spott/models/api_responses/delete_comment_api_response.dart';
import 'package:spott/models/api_responses/edit_profile_api_response.dart';
import 'package:spott/models/api_responses/follow_place_api.dart';
import 'package:spott/models/api_responses/follow_user_api_response.dart';
import 'package:spott/models/api_responses/get_all_spotted_requests_api_response.dart';
import 'package:spott/models/api_responses/get_app_notifications_model.dart';
import 'package:spott/models/api_responses/get_blocked_users_api_response.dart';
import 'package:spott/models/api_responses/get_comments_api_response.dart';
import 'package:spott/models/api_responses/get_explore_api_response.dart';
import 'package:spott/models/api_responses/get_place_categories_api_response.dart';
import 'package:spott/models/api_responses/get_place_detail_api_response.dart';
import 'package:spott/models/api_responses/get_place_suggestions_api_response.dart';
import 'package:spott/models/api_responses/get_post_interaction_api_response.dart';
import 'package:spott/models/api_responses/get_profile_api_response.dart';
import 'package:spott/models/api_responses/get_share_able_link_api_response.dart';
import 'package:spott/models/api_responses/get_user_followers_api_response.dart';
import 'package:spott/models/api_responses/get_user_following_api_response.dart';
import 'package:spott/models/api_responses/get_user_preferences_api_response.dart';
import 'package:spott/models/api_responses/get_user_spotted_posts_api_response.dart';
import 'package:spott/models/api_responses/like_dislike_api_response.dart';
import 'package:spott/models/api_responses/login_api_response.dart';
import 'package:spott/models/api_responses/logout_api_response.dart';
import 'package:spott/models/api_responses/mark_notifications_read_api_response.dart';
import 'package:spott/models/api_responses/mark_stories_as_seen_api_response.dart';
import 'package:spott/models/api_responses/place_follow_api_model.dart';
import 'package:spott/models/api_responses/place_stories_api_response.dart';
import 'package:spott/models/api_responses/place_un_follow_api_model.dart';
import 'package:spott/models/api_responses/post_reacts_model.dart';
import 'package:spott/models/api_responses/report_content_api_response.dart';
import 'package:spott/models/api_responses/request_spot_api_response.dart';
import 'package:spott/models/api_responses/search_api_response.dart';
import 'package:spott/models/api_responses/send_reset_password_email_api_response.dart';
import 'package:spott/models/api_responses/sign_up_api_response.dart';
import 'package:spott/models/api_responses/simple_api_response_model.dart';
import 'package:spott/models/api_responses/spotted_posts_api_response.dart';
import 'package:spott/models/api_responses/story_post_api_model.dart';
import 'package:spott/models/api_responses/top_places_pagination_model.dart';
import 'package:spott/models/api_responses/top_sports_pagination_model.dart';
import 'package:spott/models/api_responses/unblock_user_api_response.dart';
import 'package:spott/models/api_responses/update_follow_request_api_response.dart';
import 'package:spott/models/api_responses/update_password_api_response.dart';
import 'package:spott/models/api_responses/update_user_notification_token_api_response.dart';
import 'package:spott/models/api_responses/user_all_story_api_response.dart';
import 'package:spott/models/api_responses/view_post_api_model.dart';
import 'package:spott/models/api_responses/view_profile_api_response.dart';
import 'package:spott/models/data_models/user_preferences.dart';
import 'package:spott/resources/api_providers/all_place_posts_get_api.dart';
import 'package:spott/resources/api_providers/delete_comment_post_api.dart';
import 'package:spott/resources/api_providers/delete_post_get_api.dart';
import 'package:spott/resources/api_providers/follow_user_api_providers.dart';
import 'package:spott/resources/api_providers/logout_api_provider.dart';
import 'package:spott/resources/api_providers/notifications_api_provider.dart';
import 'package:spott/resources/api_providers/reset_password_api_provider.dart';
import 'package:spott/resources/api_providers/spot_request_accept_model.dart';
import 'package:spott/resources/api_providers/top_places_api.dart';
import 'package:spott/resources/api_providers/user_post_get_api.dart';
import 'package:spott/utils/enums.dart';

import '../models/api_responses/post_seen_api_response.dart';
import 'api_providers/block_unblock_user_api_provider.dart';
import 'api_providers/explore_api_provider.dart';
import 'api_providers/get_all_reacts_api.dart';
import 'api_providers/login_api_provider.dart';
import 'api_providers/place_api_provider.dart';
import 'api_providers/post_sptted_list_view.dart';
import 'api_providers/posts_api_provider.dart';
import 'api_providers/profile_api_provider.dart';
import 'api_providers/rating_api.dart';
import 'api_providers/report_content_api_provider.dart';
import 'api_providers/search_api_provider.dart';
import 'api_providers/share_able_links_api_provider.dart';
import 'api_providers/sign_up_api_provider.dart';
import 'api_providers/social_login_api.dart';
import 'api_providers/stories_api_provider.dart';
import 'api_providers/top_sports_api.dart';
import 'api_providers/update_follow_request_api_provider.dart';
import 'api_providers/update_spot_request_status_api_provider.dart';
import 'api_providers/user_posts_get_api.dart';
import 'api_providers/user_preferences_api_provider.dart';
import 'api_providers/view_profile_api_provider.dart';

class Repository {
  final ProfileApiProvider _profileApiProvider = ProfileApiProvider();
  final PostsApiProvider _postsApiProvider = PostsApiProvider();
  final StoriesApiProvider _storiesApiProvider = StoriesApiProvider();
  final ResetPasswordApiProvider _resetPasswordApiProvider =
      ResetPasswordApiProvider();
  final PlaceApiProvider _placeApiProvider = PlaceApiProvider();
  final NotificationsApiProvider _notificationApiProvider =
      NotificationsApiProvider();
  final UserPreferencesApiProvider _userPreferencesApiProvider =
      UserPreferencesApiProvider();
  final FollowUserApiProvider _followUserApiProvider = FollowUserApiProvider();
  final UpdateSpotRequestStatusApiRequestApiProvider
      _updateSpotRequestApiProvider =
      UpdateSpotRequestStatusApiRequestApiProvider();
  final BlockUnBlockUserAPiProvider _blockUnBlockUserAPiProvider =
      BlockUnBlockUserAPiProvider();
  final ViewProfileApiProvider _viewProfileApiProvider =
      ViewProfileApiProvider();
  final ShareAbleLinksApiProvider _shareAbleLinksApiProvider =
      ShareAbleLinksApiProvider();

  Future<SpotRequestAcceptModel> acceptSpotRequest(
    dynamic _token,
    dynamic _spotId,
  ) {
    return _updateSpotRequestApiProvider.acceptSpotRequest(_token, _spotId);
  }

  Future<AddCommentApiResponse> addComment(
      {required String token,
      required String postId,
      required String comment}) {
    return _postsApiProvider.addComment(
        token: token, postId: postId, comment: comment);
  }

  Future<AddNewPlaceApiResponse> addNewPlace(String _token, FormData _data) {
    return _placeApiProvider.addNewPlace(_token, _data);
  }

  Future<AddPostApiResponse> addNewPost(String token, FormData _formData) {
    return _postsApiProvider.addNewPost(token, _formData);
  }

  Future<BlockUserApiResponse> blockUser(String _token, String _userId) {
    return _blockUnBlockUserAPiProvider.blockUser(_token, _userId);
  }

  Future<ChangePasswordApiResponse> changePassword(
      {required String token,
      required String oldPassword,
      required String newPassword}) {
    return _resetPasswordApiProvider.changePassword(
        token: token, oldPassword: oldPassword, newPassword: newPassword);
  }

  Future<CheckConfirmationCodeApiResponse> checkConfirmationCode(
      String _email, String _code) {
    return _resetPasswordApiProvider.checkConfirmationCode(_email, _code);
  }

  Future<CreateStroyApiResponse> createStory(String token, FormData _formData) {
    return _storiesApiProvider.createStory(token, _formData);
  }

  Future<LikeDislikeApiResponse> dislikePost(
      {required String token, required String postId}) {
    return _postsApiProvider.dislikePost(token: token, postId: postId);
  }

  Future<EditProfileApiResponse> editUserProfile(
      String token, FormData _formData) {
    return _profileApiProvider.editProfile(token, _formData);
  }

  Future<FollowUserApiResponse> followUser(
      {required String token, required int userId, required int followerId}) {
    return _followUserApiProvider.followUser(
        token: token, userId: userId, followerId: followerId);
  }

  Future<GetBlockedUsersApiResponse> getAllBlockedUsers(
    String _token,
  ) {
    return _blockUnBlockUserAPiProvider.getAllBlockedUsers(_token);
  }

  Future<GetCommentsApiResponse> getAllComments(String _token, String _postId) {
    return _postsApiProvider.getAllComments(_token, _postId);
  }

  Future<GetAllSpottedRequestsApiResponse> getAllSpottRequests(
    String _token,
    int _postId,
  ) {
    return _postsApiProvider.getAllSpottRequests(_token, _postId);
  }

  Future<GetExploreApiResponse> getExploreData(
      {required String token, required double lat, required double lng}) {
    final ExploreApiProvider _apiProvider = ExploreApiProvider();
    return _apiProvider.getExploreData(token: token, lat: lat, lng: lng);
  }

  Future<TopSportsPaginationModel> getTopSpots(
      {required String token,
      required double lat,
      required double lng,
      String? nextPageUrlPlaces}) {
    return TopSpotsApi().getTopSpotsData(
        token: token, lat: lat, lng: lng, nextPageUrlPlaces: nextPageUrlPlaces);
  }

  Future<TopPlacesPaginationModel> getTopPlaces(
      {required String token,
      required double lat,
      required double lng,
      String? nextPageUrl}) {
    return TopPlacesApi().getTopPlacesData(
        token: token, lat: lat, lng: lng, nextPageUrl: nextPageUrl);
  }

  Future<GetAppNotificationsModel> getNotifications(
    String _token,
  ) {
    return _notificationApiProvider.getNotifications(_token);
  }

  Future<GetPlaceCategoriesApiResponse> getPlaceCategories({
    required String token,
    required double lat,
    required double lng,
  }) {
    return _placeApiProvider.getPlaceCategories(
        token: token, lat: lat, lng: lng);
  }

  Future<GetPlaceDetailApiResponse> getPlaceDetail(
      String _token, String _placeId) {
    return _placeApiProvider.getPlaceDetail(_token, _placeId);
  }

  Future<GetShareAbleLinkApiResponse> getPlaceShareAbleLink(
      String _token, String _placeId) {
    return _shareAbleLinksApiProvider.getPlaceShareAbleLink(_token, _placeId);
  }

  Future<GetPlaceSuggestionsApiResponse> getPlaceSuggestions(
      {required String token, required double lat, required double lng}) {
    return _placeApiProvider.getPlaceSuggestions(
        token: token, lat: lat, lng: lng);
  }

  Future<GetPostInteractionApiResponse> getPostInteractions(
      String _token, String _postId) {
    return _postsApiProvider.getPostInteractions(_token, _postId);
  }

  Future<AllPostsPaginationModel> getPosts(
    String token,
    Position? position,
    String? nextPageUrl,
  ) {
    if (position == null) {
      return _postsApiProvider.getPosts(token, 0, 0, nextPageUrl);
    } else {
      return _postsApiProvider.getPosts(
        token,
        position.latitude,
        position.longitude,
        nextPageUrl,
      );
    }
  }

  Future<StoryPostApiModel> getStories(String token, FormData data) {
    return _storiesApiProvider.getStories(token, data);
  }

  Future<GetUserFollowersApiResponse> getUserFollowers(
      String _token, int _userId) {
    return _viewProfileApiProvider.getUserFollowers(_token, _userId);
  }

  Future<GetUserFollowingApiResponse> getUserFollowing(
      String _token, int _userId) {
    return _viewProfileApiProvider.getUserFollowing(_token, _userId);
  }

  Future<UserPreferencesApiResponse> getUserPreferences(
    String _token,
  ) {
    return _userPreferencesApiProvider.getUserPreferences(_token);
  }

  Future<GetProfileApiResponse> getUserProfile(String token) {
    return _profileApiProvider.getProfile(token);
  }

  Future<GetShareAbleLinkApiResponse> getUserProfileLink(
      String _token, int _userId) {
    return _shareAbleLinksApiProvider.getUserProfileLink(_token, _userId);
  }

  Future<GetUserSpottedPostsApiResponse> getUserSpottedPosts(
      String _token, int _userId) {
    return _viewProfileApiProvider.getUserSpottedPosts(_token, _userId);
  }

  Future<LikeDislikeApiResponse> reactPost({
    required String token,
    required String postId,
    required int reactKey,
  }) {
    return _postsApiProvider.reactPost(
        token: token, postId: postId, reactKey: reactKey);
  }

  Future<LoginApiResponse> loginUser(String _email, String _password) {
    final LoginApiProvider _apiProvider = LoginApiProvider();
    return _apiProvider.loginUser(_email, _password);
  }

  Future<LogoutApiResponse> logoutUser(String _token) {
    final LogoutApiProvider _apiProvider = LogoutApiProvider();
    return _apiProvider.logoutUser(_token);
  }

  Future<MarkNotificationsReadApiResponse> markNotificationsRead(
      String _token, List<int> _ids) {
    return _notificationApiProvider.markNotificationsRead(_token, _ids);
  }

  Future<MarkStoriesAsSeenApiResponse> markStoryAsSeen(
      String token, int storyId) {
    return _storiesApiProvider.markStoryAsSeen(token, storyId);
  }
  Future<PostSeenApiResponse> markPostAsSeen(
      String token, int postId) {
    return _storiesApiProvider.markPostAsSeen(token, postId);
  }


  Future<SpotRequestAcceptModel> rejectSpotRequest(
      dynamic _token, dynamic _spotId) {
    return _updateSpotRequestApiProvider.rejectSpotRequest(_token, _spotId);
  }

  Future<ReportContentApiResponse> reportContent(
      {required String token, required int contentId, required String type}) {
    final ReportContentApiProvider _apiProvider = ReportContentApiProvider();
    return _apiProvider.reportContent(
        token: token, contentId: contentId, type: type);
  }

  Future<RequestSpotApiResponse> requestPostSpot(
      String _token, String _postId) {
    return _postsApiProvider.requestPostSpot(_token, _postId);
  }

  Future<RequestSpotApiResponse> requestStorySpot(
      String _token, String _storyId) {
    return _storiesApiProvider.requestStorySpot(_token, _storyId);
  }

  Future<SearchApiResponse> search(
      {required String token, required String keyWord}) {
    final SearchApiProvider _apiProvider = SearchApiProvider();
    return _apiProvider.search(token: token, keyWord: keyWord);
  }

  Future<SendResetPasswordEmailApiResponse> sendResetPasswordEmail(
      String _email) {
    return _resetPasswordApiProvider.sendResetPasswordEmail(_email);
  }

  Future<SignUpApiResponse> signUp(FormData _formData) {
    final SignUpApiProvider _apiProvider = SignUpApiProvider();
    return _apiProvider.signUp(_formData);
  }

  Future<UnblockUserApiResponse> unblockUser(String _token, String _userId) {
    return _blockUnBlockUserAPiProvider.unblockUser(_token, _userId);
  }

  Future<FollowUserApiResponse> unFollowUser({
    required String token,
    required int userId,
    required int followerId,
  }) {
    return _followUserApiProvider.unFollowUser(
      token: token,
      userId: userId,
      followerId: followerId,
    );
  }

  Future<UpdateFollowRequestApiResponse> updateFollowRequestStatus(
      {required String token,required Map data}) {
    final UpdateFollowRequestApiProvider _apiProvider =
        UpdateFollowRequestApiProvider();
    return _apiProvider.updateFollowRequestStatus(
        token: token, data: data);
  }

  Future<UpdatePasswordApiResponse> updatePassword(
      {required String email, required String code, required String password}) {
    return _resetPasswordApiProvider.updatePassword(
        email: email, code: code, password: password);
  }

  Future<UpdateUserNotificationTokenApiResponse> updateUserNotificationToken(
      String _token, String _oneSignalToken) {
    return _notificationApiProvider.updateUserNotificationToken(
        _token, _oneSignalToken);
  }

  Future<UserPreferencesApiResponse> updateUserPreferences(String _token, UserPreferences _preferences) {
    return _userPreferencesApiProvider.updateUserPreferences(_token, _preferences);
  }

  Future<ViewProfileApiResponse> viewProfileApiProvider(
      String _token, int _userId) {
    return _viewProfileApiProvider.viewUserProfile(_token, _userId);
  }

  Future<AddRatingResponseModel> placeRating(
      String review, String rating, String placeId, String token) {
    return RatingApi().addRating(review, rating, placeId, token);
  }

  Future<AllRatingApiResponseModel> getAllRating(
      String placeId, String token) async {
    return RatingApi().getAllRating(placeId, token);
  }

  Future<SpottedPostsApiResponse> getSpottedListModel(String placeId) {
    return PostSpottedListViewApi().getSpottedListView(placeId);
  }

  Future<LoginApiResponse> socialLogin(String email) {
    return SocialLoginApi().loginWithGoogle(email);
  }

  Future<PostReactsModel> getAllReacts(String postId) async {
    return GetPostReact().getAllReacts(postId);
  }

  Future<PlaceFollowApiModel> followPlace(String placeId) {
    return FollowPlaceApi().placeFollowApi(placeId);
  }

  Future<PlaceUnFollowApiModel> unfollowPlace(String placeId) {
    return FollowPlaceApi().placeUnFollowApi(placeId);
  }

  Future<ViewPostApiModel> getPostData(int postId) {
    return UserPostGetApi().getUserPost(postId);
  }

  Future<SimpleApiResponseModel> deletePost(int postId) {
    return PostDeleteGetApi().deleteGetRequest(postId);
  }

  Future<DeleteCommentApiResponse> deleteComment(
      {required String token, required int commentId}) {
    return DeleteCommentPostApi()
        .deleteComment(token: token, commentId: commentId);
  }

  Future<UserAllStoryApiResponse> getAllUserPosts(
      {required String token, required String id}) {
    return UserStoryPostsGetApi().getAllUserPosts(token, id);
  }

  Future<AllPlacePostsApiResponse> getAllPlacePosts(
      {required String token, required String id}) {
    return AllPostsGetApi().getAllPlacePosts(token, id);
  }
  Future<PlaceStoriesApiResponse> placeAllStories(
      {required String token, required String id}) {
    return PlaceApiProvider().placeAllStory(token, id);
  }
}
