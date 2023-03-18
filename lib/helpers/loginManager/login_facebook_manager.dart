
import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../representation/screens/main_screen.dart';

class LoginFacebookManager {
  static final LoginFacebookManager _shared = LoginFacebookManager._internal();
  factory LoginFacebookManager() {
    return _shared;
  }
  LoginFacebookManager._internal();

  static Future<bool> isLogged() async {
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      return true;
    }
    return false;
  }

  static void logOut() {
    () async {
      await FacebookAuth.instance.logOut();
    }();
  }

  static void loginAndNextScreen(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      if (!context.mounted) return;
      Navigator.pushNamed(context, MainScreen.routeName);
    } else {
      print(result.status);
      print(result.message);
    }
  }

}
