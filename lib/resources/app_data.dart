import 'package:camera/camera.dart';
import 'package:spott/models/data_models/user.dart';

class AppData {
  AppData._();

  static String? _accessToken;
  static User? _currentUser;

  static String? get accessToken => _accessToken;
  static User? get currentUser => _currentUser;

  /// check if app already have handled initial Urls
  static bool initialUriIsHandled = false;

  // ignore: use_setters_to_change_properties
  static void setAccessToken(String? token) {
    _accessToken = token;
  }

  // ignore: use_setters_to_change_properties
  static void setCurrentUser(User? user) {
    _currentUser = user;
  }

  //! all the available cameras that a device have
  static List<CameraDescription>? _cameras;

  static List<CameraDescription>? get cameras => _cameras;

  // ignore: use_setters_to_change_properties
  static void setCameras(List<CameraDescription>? cameras) {
    _cameras = cameras;
  }
}
