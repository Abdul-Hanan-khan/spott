import 'package:google_sign_in/google_sign_in.dart';

// ignore: avoid_classes_with_only_static_members
class GoogleSignInService {
  static final _googleSignIn = GoogleSignIn(

  );

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<GoogleSignInAccount?> signOut() => _googleSignIn.disconnect();
}
