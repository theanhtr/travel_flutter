import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

class AddRoomsController {
  Future<bool> addRooms(
    String typeRoomId,
    String quantity,
  ) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .post('/my-hotel/rooms/add-rooms', {
      "type_room_id": typeRoomId,
      "quantity": quantity,
    }).catchError((onError) {
      return false;
    });
    if (response == null) {
      return false;
    }
    return true;
  }
}
