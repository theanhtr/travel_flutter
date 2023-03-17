import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

import '../../representation/screens/main_screen.dart';

class LoginFacebookManager extends LoginManager {
  static final LoginFacebookManager _shared = LoginFacebookManager._internal();
  factory LoginFacebookManager() {
    return _shared;
  }

  LoginFacebookManager._internal();
  @override
  Future<bool> isLogIn() async {
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      return true;
    }
    return false;
  }

  void logOut() {
    () async {
      await FacebookAuth.instance.logOut();
    }();
  }

  @override
  void loginAndNextScreen(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      if (!context.mounted) return;
      Navigator.popAndPushNamed(context, MainScreen.routeName);
    } else {
      print(result.status);
      print(result.message);
    }
  }

}
