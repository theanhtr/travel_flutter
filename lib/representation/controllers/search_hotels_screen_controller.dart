import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';

import '../../helpers/http/base_client.dart';
import '../../helpers/loginManager/login_manager.dart';

class SearchHotelsScreenController {
  Future<String> getDistanceInformation(String address) async {
    return LocationHelper().getDistanceInformation(address);
  }

  Future<dynamic> getHotelDetail(int hotelId) async {
    // debugPrint("token dong 15: ${LoginManager().userModel.token}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    var response = await BaseClient(token ?? "")
        .get('/searches/hotels/$hotelId')
        .catchError((onError) {
      return onError;
    });
    if (response.runtimeType == int) {
      debugPrint("co data tra ve sau khi search hotel loi");
      return response;
    }
    if (response.runtimeType == String) {
      debugPrint("co data tra ve sau khi search hotel");
      Map dataResponse = await json.decode(response);
      return dataResponse['data'];
    }
    return false;
  }
}
