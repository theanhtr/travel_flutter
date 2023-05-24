import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';

class HotelOwnerManager {
  static final HotelOwnerManager _shared = HotelOwnerManager._internal();
  List<dynamic> _amenityList = [];
  List<dynamic> _typeRoomList = [];
  factory HotelOwnerManager() {
    return _shared;
  }

  HotelOwnerManager._internal();
  List<dynamic> get getListAmenities {
    return _amenityList;
  }

  List<dynamic> get getTypeRoomList {
    return _typeRoomList;
  }

  // Future<Map> deleteHotel(int id) async {
  //   final token = await LocalStorageHelper.getValue("userToken") as String?;
  //   final _id = id.toString();
  //   final response = await BaseClient(token!)
  //       .delete("/hotels/delete/", _id)
  //       .catchError((err) {
  //     debugPrint(err);
  //     return false;
  //   });
  //   Map resultmap = Map<String, String>();
  //   if (response.runtimeType == int) {
  //     resultmap['result'] = 'statuscode $response';
  //     return resultmap;
  //   }
  //   if (response == null) {
  //     resultmap['result'] = 'null response';
  //     return resultmap;
  //   }
  //   Map dataResponse = json.decode(response);
  //   return dataResponse;
  // }

  Future<Map> deleteAmenities(String amenities) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!)
        .deleteAmenities("/my-hotel/amenities", amenities)
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

  Future<Map> viewAllAmenities() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token!).get("/my-hotel/amenities").catchError((err) {
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
    _amenityList = dataResponse['data'];
    return dataResponse;
  }

  Future<Map> getAllTypeRoom() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token!).get("/my-hotel/type-rooms").catchError((err) {
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
    _typeRoomList = dataResponse['data'];
    return dataResponse;
  }

  // Future<Map> getRole() async {
  //   // print("token day: ${LocalStorageHelper.getValue("userToken")}");
  //   final token = await LocalStorageHelper.getValue("userToken") as String?;
  //   final response =
  //       await BaseClient(token!).get("/users/get-role").catchError((err) {
  //     debugPrint(err);
  //     return false;
  //   });
  //   Map resultmap = Map<String, String>();
  //   if (response == null) {
  //     resultmap['result'] = 'null response';
  //     return resultmap;
  //   }
  //   Map dataResponse = json.decode(response);
  //   // debugPrint('List hotel dong 44 admin manager: ${dataResponse}');
  //   _amenityList = dataResponse['data'];
  //   return dataResponse;
  // }

  Future<Map> addAmenities(String amenities) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).post(
        "/my-hotel/amenities", {"amenities": amenities}).catchError((err) {
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

  // Future<Map> createUser(String email, int? id) async {
  //   final token = await LocalStorageHelper.getValue("userToken") as String?;
  //   final response = await BaseClient(token ?? "")
  //       .postNewUser("/users/create-new-user", email, id)
  //       .catchError((err) {
  //     debugPrint(err);
  //     return false;
  //   });
  //   Map resultmap = Map<String, String>();
  //   print('response 193: $response');
  //   if (response.runtimeType == int) {
  //     return response;
  //   }
  //   if (response == null) {
  //     resultmap['result'] = 'null response';
  //     return resultmap;
  //   }
  //   Map dataResponse = json.decode(response);

  //   return dataResponse;
  // }

  // Future<Map> changeRole(
  //   String email,
  //   int? roleId,
  // ) async {
  //   print("dong 165 admin: $email , $roleId");
  //   final token = await LocalStorageHelper.getValue("userToken") as String?;
  //   final response = await BaseClient(token ?? "")
  //       .postRoleId("/users/change-role", email, roleId)
  //       .catchError((err) {
  //     debugPrint(err);
  //     return false;
  //   });
  //   Map resultmap = Map<String, String>();
  //   if (response == null) {
  //     resultmap['result'] = 'null response';
  //     return resultmap;
  //   }
  //   Map dataResponse = json.decode(response);

  //   return dataResponse;
  // }
}
