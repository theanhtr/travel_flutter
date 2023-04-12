
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

import '../../helpers/http/base_client.dart';

class LoginScreenController {
  Future<dynamic> loginByPassWord(String email, String password) async {
     return LoginManager().signInWithEmailPassword(email, password);
  }
}
