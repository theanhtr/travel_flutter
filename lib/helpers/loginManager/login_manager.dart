
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_facebook_manager.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_google_manager.dart';

abstract class LoginManager {
  static LoginManager shared(String type) {
  switch (type) {
  case 'facebook':
  return LoginFacebookManager();
  default:
  return LoginGoogleManager();
  }
}

  Future<bool> isLogIn();

  static Future<bool> isLogged() async {
    if (await LoginFacebookManager().isLogIn()) {
      return true;
    }
    if (await LoginGoogleManager().isLogIn()) {
      return true;
    }
    return false;
  }

  static void logOut() {
    LoginFacebookManager().logOut();
    LoginGoogleManager().logOut();
  }

  void loginAndNextScreen(BuildContext context);
}
