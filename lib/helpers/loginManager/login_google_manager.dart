import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../../representation/screens/main_screen.dart';

class LoginGoogleManager {
  static final LoginGoogleManager _shared = LoginGoogleManager._internal();
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  factory LoginGoogleManager() {
    return _shared;
  }

  LoginGoogleManager._internal();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final googleCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(googleCredential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
      // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(googleCredential);
  }

}