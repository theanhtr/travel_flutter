import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';

class LoginManager {
  static final LoginManager _shared = LoginManager._internal();

  factory LoginManager() {
    return _shared;
  }

  LoginManager._internal();

  final UserModel userModel = UserModel();

  Future<void> setUserModel() async {
    if (userModel.photoUrl == null && userModel.name == null) {
      userModel.email = await LocalStorageHelper.getValue("userEmail");
      userModel.token = await LocalStorageHelper.getValue("userToken");
      await getCurrentUser().then((value) async => {
            if (await LocalStorageHelper.getValue("userName") == null)
              {LocalStorageHelper.setValue("userName", value?.name)}
          });
      await getCurrentUserAvatar()
          .then((value) => {userModel.photoUrl = value});
      userModel.name = await LocalStorageHelper.getValue("userName");
      print(userModel.photoUrl);
    }
  }

  //private
  var _isRemember = true;

  Future<bool> signInWithEmailPassword(String email, String password) async {
    var response = await BaseClient("")
        .post('/auth/login', {'email': email, 'password': password}).catchError(
            (err) {
      debugPrint(err);
    });
    if (response == null) return false;
    Map dataResponse = await json.decode(response);
    var token = await dataResponse['data']['token'];
    if (_isRemember == true) {
      final userToken =
          await LocalStorageHelper.getValue('userToken') as String?;
      if (userToken == null) {
        LocalStorageHelper.setValue("userToken", token);
        LocalStorageHelper.setValue("userEmail", email);
      }
    }
    await setUserModel();
    return dataResponse['success'];
  }

  void remember(bool isRemember) {
    _isRemember = isRemember;
  }

  Future<bool> isLogin() async {
    if (LocalStorageHelper.getValue("userToken") == null) {
      return false;
    } else {
      await setUserModel();
      return true;
    }
  }

  Future<String> getCurrentUserAvatar() async {
    var response = await BaseClient(userModel.token ?? "")
        .get('/my-avatar')
        .catchError((err) {
      debugPrint(err);
    });
    if (response == null) return "";
    Map dataResponse = json.decode(response);
    return dataResponse['data']['path'];
  }

  Future<UserModel?> getCurrentUser() async {
    var response = await BaseClient(userModel.token ?? "")
        .get('/my-information')
        .catchError((err) {
      debugPrint("response get currentuser err $err");
    });
    if (response == null) return null;
    if (response == 200) {
      Map dataResponse = json.decode(response);
      return UserModel(
        name: dataResponse['data']['last_name'],
        id: dataResponse['data']['id'],
        email: dataResponse['data']['email'],
      );
    }
  }

  Future<bool> signOut() async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    if (token != null) {
      var response = await BaseClient(token).post('/auth/logout', {
        'allDevice': false,
      }).catchError((err) {
        debugPrint(err);
      });
      if (response == null) return false;
      Map dataResponse = json.decode(response);
      if (dataResponse['success'] == true) {
        LocalStorageHelper.deleteValue("userToken");
        LocalStorageHelper.deleteValue("userEmail");
        LocalStorageHelper.deleteValue("userName");
        LocalStorageHelper.deleteValue("photoUrl");
        return true;
      }
    }
    return false;
  }

  //signUp
  Future<Map> signUpByPassword(
      String email, String password, String passwordConfirmation) async {
    final response = await BaseClient("").post("/auth/register", {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    }).catchError((err) {
      debugPrint(err);
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);

    return dataResponse;
  }
}
