
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

class HomeScreenController {

  UserModel? getUser() {
    if (FirebaseAuth.instance.currentUser != null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      return UserModel(
        email: currentUser?.email,
        name: currentUser?.displayName,
        photoUrl: currentUser?.photoURL,
      );
    } else {
      return LoginManager().userModel;
    }
  }
}
