import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../../helpers/http/base_client.dart';

class UserController {
  Future<dynamic> loginByPassWord(String email, String password) async {
    return LoginManager().signInWithEmailPassword(email, password);
  }

//String email, String password, String passwordConfirmation
  Future<dynamic> createUserInfor(String email, String firstName,
      String lastName, String phone_number, DateTime date_of_birth) {
    return LoginManager().createUsetInformation(
        email, firstName, lastName, phone_number, date_of_birth);
  }

  Future<dynamic> updateUserInfor(String email, String firstName,
      String lastName, String phone_number, DateTime date_of_birth) {
    debugPrint("email day ${email}");
    return LoginManager().UpdateUserInformation(
        email, firstName, lastName, phone_number, date_of_birth);
  }
}
