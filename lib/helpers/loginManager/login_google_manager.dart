import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

import '../../representation/screens/main_screen.dart';

class LoginGoogleManager extends LoginManager {

  @override
  Future<bool> isLogIn() async {
    // Hải Anh viết hàm kiểm tra đã login chưa ở đây
    return false;
  }

  void logOut() {
    print("ggggg logout");
  }

  @override
  void loginAndNextScreen(BuildContext context) async {
    //loginggg ở đây nhâsss.
    print("ggggg loginnnn");
  }

}