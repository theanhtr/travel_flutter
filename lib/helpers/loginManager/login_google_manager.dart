import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogleManager {
  static final LoginGoogleManager _shared = LoginGoogleManager._internal();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  factory LoginGoogleManager() {
    return _shared;
  }

  LoginGoogleManager._internal();

  Future<String?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleAuth?.accessToken == null || googleAuth?.idToken == null) {
      return null;
    }

    return googleAuth?.idToken;
  }

}