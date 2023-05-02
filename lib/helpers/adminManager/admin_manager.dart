import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';

class AdminManager {
  static final AdminManager _shared = AdminManager._internal();

  factory AdminManager() {
    return _shared;
  }

  AdminManager._internal();
  Future<Map> deleteHotel(String id) async {
    final response =
        await BaseClient("").delete("/hotels/delete", id).catchError((err) {
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

  //   Future<Map> createUser(String email, String id) async {
  //   final response =
  //       await BaseClient("").post("/users/create-new-user", id).catchError((err) {
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
