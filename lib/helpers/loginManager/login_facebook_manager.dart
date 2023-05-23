import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginFacebookManager {
  static final LoginFacebookManager _shared = LoginFacebookManager._internal();
  factory LoginFacebookManager() {
    return _shared;
  }
  LoginFacebookManager._internal();

  Future<String?> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      return null;
    }

    return loginResult.accessToken?.token;
  }

}
