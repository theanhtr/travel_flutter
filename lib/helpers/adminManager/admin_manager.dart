import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';

class AdminManager {
  static final AdminManager _shared = AdminManager._internal();
  List<dynamic> _hotelsList = [];
  List<dynamic> _userList = [];
  factory AdminManager() {
    return _shared;
  }

  AdminManager._internal();
  List<dynamic> get getListHotel {
    return _hotelsList;
  }

  List<dynamic> get getUserList {
    return _userList;
  }

  Future<Map> deleteHotel(int id) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final _id = id.toString();
    final response = await BaseClient(token!)
        .delete("/hotels/delete/", _id)
        .catchError((err) {
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

  Future<Map> deleteUser(String email) async {
    print('email delete: $email');
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!)
        .deleteUser("/users/delete-user", email)
        .catchError((err) {
      debugPrint("loi delete user: $err");
      return false;
    });
    debugPrint("loi 58: $response");
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

  Future<Map> viewAllHotel() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).get("/hotels").catchError((err) {
      debugPrint(err);
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    // debugPrint('List hotel dong 44 admin manager: ${dataResponse}');
    _hotelsList = dataResponse['data'];
    return dataResponse;
  }

  Future<Map> getAllUser() async {
    print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).get("/users").catchError((err) {
      debugPrint(err);
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    // debugPrint('List user dong 101: ${dataResponse}');
    _userList = dataResponse['data'];
    return dataResponse;
  }

  Future<Map> getRole() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token!).get("/users/get-role").catchError((err) {
      debugPrint(err);
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    // debugPrint('List hotel dong 44 admin manager: ${dataResponse}');
    _hotelsList = dataResponse['data'];
    return dataResponse;
  }

  Future<Map> getOneUser(String email) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!)
        .post("/users/get-by-email", {"email": email}).catchError((err) {
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

  String checkRole(int? id) {
    String roleString = "";
    switch (id) {
      case 1:
        roleString = LocalizationText.admin;
        break;
      case 2:
        roleString = LocalizationText.user;
        break;
      case 3:
        roleString = LocalizationText.hotelManager;
        break;
    }

    return roleString;
  }

  int? checkRoleString(String? roleName) {
    int? roleid;
    debugPrint(roleName.toString());
    switch (roleName) {
      case "Admin":
        roleid = 1;
        break;
      case "Quản trị viên":
        roleid = 1;
        break;
      case "Customer":
        roleid = 2;
        break;
      case "Người dùng":
        roleid = 2;
        break;
      case "Hotel Manager":
        roleid = 3;
        break;
      case "Chủ khách sạn":
        roleid = 3;
        break;
      case "Travel Staff":
        roleid = 4;
        break;
      case "Điều phối viên":
        roleid = 4;
        break;
    }

    return roleid;
  }

  Future<Map> createUser(String email, int? id) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token ?? "")
        .postNewUser("/users/create-new-user", email, id)
        .catchError((err) {
      debugPrint(err);
      return false;
    });
    Map resultmap = Map<String, String>();
    print('response 193: $response');
    if (response.runtimeType == int) {
      return response;
    }
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);

    return dataResponse;
  }

  Future<Map> changeRole(
    String email,
    int? roleId,
  ) async {
    print("dong 165 admin: $email , $roleId");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token ?? "")
        .postRoleId("/users/change-role", email, roleId)
        .catchError((err) {
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
