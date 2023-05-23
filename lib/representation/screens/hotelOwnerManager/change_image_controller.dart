import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

class ChangeImageController {
  Future<bool> deleteTypeRoomImage(
    String typeRoomId,
    int imageId,
  ) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .deleteWithBody('/my-hotel/type-rooms/$typeRoomId/images', {
      "images_id": "$imageId",
    }).catchError((onError) {
      return onError;
    });
    if (response == null) {
      return false;
    }
    if (response.runtimeType != String) {
      return false;
    }
    Map dataResponse = json.decode(response);
    if (dataResponse['success'] != null) {
      if (!dataResponse['success']) {
        return false;
      }
    }
    return true;
  }
}
