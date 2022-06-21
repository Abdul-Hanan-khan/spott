import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spott/models/data_models/user.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/utils/constants/preferences_constants.dart';

class PreferencesController {
  PreferencesController._();

  static final GetStorage _storage = GetStorage();

  static void saveUserInfo(String _accessToken, User _user) {
    AppData.setAccessToken(_accessToken);
    AppData.setCurrentUser(_user);
    _storage.write(PreferencesConstants.userAccessTokenKey, _accessToken);
    _storage.write(
        PreferencesConstants.userModelKey, jsonEncode(_user.toJson()));
  }

  static bool isNewUser() {
    final String? _accessToken =
        _storage.read(PreferencesConstants.userAccessTokenKey);
    final String? _user = _storage.read(PreferencesConstants.userModelKey);
    if (_accessToken == null) return true;
    AppData.setAccessToken(_accessToken);
    if (_user != null) {
      AppData.setCurrentUser(
        User.fromJson(
          jsonDecode(_user),
        ),
      );
    }
    return false;
  }

  static void signOutUser() {
    AppData.setAccessToken(null);
    _storage.remove(PreferencesConstants.userAccessTokenKey);
  }

  static void saveUserLocation(Position _position) {
    _storage.write(
      PreferencesConstants.userLocationKey,
      jsonEncode(
        _position.toJson(),
      ),
    );
  }

  static Position? getUserLocation() {
    final String? value = _storage.read(PreferencesConstants.userLocationKey);
    if (value == null) return null;
    return Position.fromMap(jsonDecode(value));
  }

  static void rememberUserHaveSentFirstSpott() {
    _storage.write(PreferencesConstants.alreadySentSpottKey, true);
  }

  static bool isUserSentFirstSpottRequest() {
    final value = _storage.read(PreferencesConstants.alreadySentSpottKey);
    return value != null;
  }
  static void rememberLiked() {
    _storage.write(PreferencesConstants.alreadyReact, true);
  }

}
