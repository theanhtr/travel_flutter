
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenController {

  User? getUser() {
     return FirebaseAuth.instance.currentUser;
  }
}
