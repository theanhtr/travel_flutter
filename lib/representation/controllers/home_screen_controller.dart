
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_facebook_manager.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_google_manager.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

class HomeScreenController {

  User? getUser() {
     return FirebaseAuth.instance.currentUser;
  }
}
