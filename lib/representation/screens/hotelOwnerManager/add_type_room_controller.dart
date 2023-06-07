import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

class AddTypeRoomController {
  Future<bool> addTypeRoom(
      String roomName,
      String description,
      String price,
      String occupancy,
      String numberOfBeds,
      String roomSize,
      String amenities) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .post('/my-hotel/type-rooms', {
      "name": roomName,
      "description": description,
      "price": int.parse(price),
      "occupancy": int.parse(occupancy),
      "number_of_beds": int.parse(numberOfBeds),
      "amenities": amenities,
      "room_size": int.parse(roomSize),
    }).catchError((onError) {
      return false;
    });
    if (response == null) {
      return false;
    }
    return true;
  }
}
