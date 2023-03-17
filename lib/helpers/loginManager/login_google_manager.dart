import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../../representation/screens/main_screen.dart';

class LoginGoogleManager extends LoginManager {
  static final LoginGoogleManager _shared = LoginGoogleManager._internal();
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  factory LoginGoogleManager() {
    return _shared;
  }

  LoginGoogleManager._internal();

  @override
  Future<bool> isLogIn() async {
    return await _googleSignIn.isSignedIn();
  }

  void logOut() {
    () async {
      await _googleSignIn.signOut();
    }();
  }

  @override
  void loginAndNextScreen(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      if (await _googleSignIn.isSignedIn()) {
        Navigator.popAndPushNamed(context, MainScreen.routeName);
      }
    } catch (error) {
      print(error);
    }
  }

}