import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

class HomeScreenController {
  UserModel? getUser() {
    return LoginManager().userModel;
  }

  Future<dynamic> getPopularDestination() async {
    print('hehehehehe ${LoginManager().userModel.token}');
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .get("/popular-destination")
        .catchError((err) {
      return err;
    });
    if (response == null) {
      return false;
    }
    print('hehehehehe ${response.toString()}');
    if (response.runtimeType == String) {
      Map dataResponse = json.decode(response);
      return dataResponse['data'];
    }
    return false;
  }

  Future<dynamic> likePopularDestination(int destinationId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "").post(
        "/likes/popular-destination/$destinationId", {}).catchError((err) {
      debugPrint(err);
      return false;
    });

    if (response == null) {
      return false;
    }
    Map dataResponse = json.decode(response);
    if (dataResponse['success'] == true) {
      return dataResponse['data']['is_like'];
    }
  }
}
