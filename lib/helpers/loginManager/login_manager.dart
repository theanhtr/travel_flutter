import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
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
  late UserModel userModelProfile = UserModel();

  Future<void> setUserModel() async {
    userModel.email = await LocalStorageHelper.getValue("userEmail");
    userModel.token = await LocalStorageHelper.getValue("userToken");
    await getCurrentUser().then((value) async => {
          if (await LocalStorageHelper.getValue("userName") == null)
            {
              await LocalStorageHelper.setValue("userName", value?.name),
            }
        });
    await getCurrentUserAvatar().then((value) async => {
          if (await LocalStorageHelper.getValue("photoUrl") == null)
            {
              await LocalStorageHelper.setValue("photoUrl", value),
            }
        });
    userModel.name = await LocalStorageHelper.getValue("userName");
    userModel.photoUrl = await LocalStorageHelper.getValue("photoUrl");
  }

  Future<void> setUserProfileModel() async {
    await getCurrentUser().then((value) async => {
          userModelProfile.firstName = value?.firstName,
          userModelProfile.lastName = value?.lastName,
          userModelProfile.dateOfBirth = value?.dateOfBirth,
          userModelProfile.phoneNumber = value?.phoneNumber,
          userModelProfile.photoUrl = value?.photoUrl,
          userModelProfile.email = value?.email,
        });
  }

  //private
  var _isRemember = true;

  Future<dynamic> signInWithEmailPassword(String email, String password) async {
    email = email.replaceAll(' ', '');
    password = password.replaceAll(' ', '');
    var response = await BaseClient("")
        .post('/auth/login', {'email': email, 'password': password}).catchError(
            (err) {
      return err;
    });
    if (response == null) return false;
    if (response.runtimeType == int) {
      return response;
    }
    Map dataResponse = await json.decode(response);
    var token = await dataResponse['data']['token'];
    if (_isRemember == true) {
      final userToken = await LocalStorageHelper.getValue('userToken');
      if (userToken == null) {
        await LocalStorageHelper.setValue("userToken", token);
        await LocalStorageHelper.setValue("userEmail", email);
        await setUserModel();
        await setUserProfileModel();
      }
    }
    return dataResponse;
  }

  void remember(bool isRemember) {
    _isRemember = isRemember;
  }

  Future<bool> isLogin() async {
    if (await LocalStorageHelper.getValue("userToken") == null) {
      return false;
    } else {
      await setUserModel();
      await setUserProfileModel();
      return true;
    }
  }

  Future<String> getCurrentUserAvatar() async {
    var response = await BaseClient(userModel.token ?? "")
        .get('/my-information/avatar')
        .catchError((err) {
      debugPrint(err);
    });
    if (response == null)
      return "https://cdn.mos.cms.futurecdn.net/JarKa4TVZxSCuN8x8WNPSN.jpg";
    Map dataResponse = json.decode(response);
    if (dataResponse['data']['success'] == false) {
      return "https://cdn.mos.cms.futurecdn.net/JarKa4TVZxSCuN8x8WNPSN.jpg";
    }
    return dataResponse['data']['path'];
  }

  Future<UserModel?> getCurrentUser() async {
    final userToken = userModel.token;
    var response = await BaseClient(userToken ?? "")
        .get('/my-information')
        .catchError((err) {
      debugPrint("response get currentuser err $err");
    });
    if (response == null) return null;
    if (response.runtimeType == int) {
      return null;
    }
    Map dataResponse = json.decode(response);

    debugPrint(dataResponse['data']['date_of_birth']);
    return UserModel(
        name: dataResponse['data']['last_name'],
        id: dataResponse['data']['id'],
        firstName: dataResponse['data']['first_name'],
        lastName: dataResponse['data']['last_name'],
        phoneNumber: dataResponse['data']['phone_number'],
        photoUrl: dataResponse['data']['avatar'],
        dateOfBirth: dataResponse['data']['date_of_birth'],
        email: dataResponse['data']['email']);
  }

  Future<bool> signOut() async {
    final token = userModel.token;
    if (token != null) {
      var response = await BaseClient(token).post('/auth/logout', {
        'allDevice': false,
      }).catchError((err) {
        debugPrint(err);
      });
      if (response == null) return false;
      debugPrint("144 $response");
      Map dataResponse = json.decode(response);
      if (dataResponse['success'] == true) {
        await LocalStorageHelper.deleteValue("userToken");
        await LocalStorageHelper.deleteValue("userEmail");
        await LocalStorageHelper.deleteValue("userName");
        await LocalStorageHelper.deleteValue("photoUrl");
        userModel.token = null;
        userModel.email = null;
        userModel.name = null;
        userModel.photoUrl = null;
        return true;
      }
    }
    return false;
  }

  //signUp
  Future<Map> signUpByPassword(
      String email, String password, String passwordConfirmation) async {
    email = email.trim();
    password = password.trim();
    passwordConfirmation = passwordConfirmation.trim();
    final response = await BaseClient("").post("/auth/register", {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    }).catchError((err) {
      debugPrint(err);
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response.runtimeType == int) {
      resultmap['result'] = 'statuscode $response';
      return resultmap;
    }
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);

    return dataResponse;
  }

  Future<dynamic> forgotPassword(String email) async {
    email = email.trim();
    final response = await BaseClient("").post("/auth/forgot-password", {
      "email": email,
    }).catchError((err) {
      return false;
    });
    if (response == null) {
      return false;
    }
    if (response.runtimeType == int) {
      return response;
    }
    Map dataResponse = json.decode(response);
    if (dataResponse['success'] == true) {
      return true;
    }
    return dataResponse;
  }

  Future<dynamic> verificateCode(String email, String code) async {
    email = email.trim();
    code = code.trim();
    final response =
        await BaseClient("").post("/auth/check-token-reset-password", {
      "email": email,
      "token": code,
    }).catchError((err) {
      return false;
    });
    if (response == null) {
      return false;
    }
    if (response.runtimeType == int) {
      return response;
    }
    Map dataResponse = json.decode(response);
    if (dataResponse['success'] == true) {
      return true;
    }
    return false;
  }

  Future<dynamic> resetPassword(String email, String password,
      String passwordConfirm, String token) async {
    email = email.trim();
    password = password.trim();
    passwordConfirm = passwordConfirm.trim();
    final response = await BaseClient("").post("/auth/reset-password", {
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirm,
      "token": token,
    }).catchError((err) {
      return false;
    });
    if (response == null) {
      return false;
    }
    if (response.runtimeType == int) {
      return response;
    }
    Map dataResponse = json.decode(response);
    if (dataResponse['success'] == true) {
      return true;
    }
    return response;
  }

  Future<Map> createUsetInformation(String email, String firstName,
      String lastName, String phone_number, DateTime date_of_birth) async {
    final token = userModel.token;
    final response =
        await BaseClient(token ?? "").postHaiAnhDung("/my-information", {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phone_number,
      "date_of_birth": DateFormat("yyyy-MM-dd hh:mm:ss").format(date_of_birth),
    }).catchError((err) {
      debugPrint("hwc hce");
      return false;
    });
    Map dataResponse = Map<String, String>();
    dataResponse = json.decode(response);

    return dataResponse;
  }

  Future<Map> UpdateUserInformation(String email, String firstName,
      String lastName, String phone_number, DateTime date_of_birth) async {
    final token = userModel.token;
    final response = await BaseClient(token ?? "").put("/my-information", {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phone_number,
      "date_of_birth": DateFormat("yyyy-MM-dd").format(date_of_birth),
    }).catchError((err) {
      debugPrint("hwc hce");
      return false;
    });
    Map dataResponse = Map<String, String>();
    dataResponse = json.decode(response);

    return dataResponse;
  }

  uploadFileFromDio(UserModel userProfile, XFile photoFile) async {
    final token = userModel.token;
    try {
      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = baseUrl;

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Authorization': 'Bearer ${token}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData = new dio.FormData.fromMap({
        'first_name': '${userProfile.firstName}',
        'last_name': '${userProfile.lastName}',
        'date_of_birth': '${userProfile.dateOfBirth}',
        'phone_number': '${userProfile.phoneNumber}',
      });

      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(photoFile.path,
          filename: basename(photoFile.path),
          contentType: MediaType("image", basename(photoFile.path)));

      formData.files.add(MapEntry('image', file));

      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        baseUrl,
        data: formData,
      );

      debugPrint("Dong 339 ket qua upload thong tin ngươi dufg: ${response}");
    } catch (err) {
      print('ERROR  $err');
    }
  }
}
