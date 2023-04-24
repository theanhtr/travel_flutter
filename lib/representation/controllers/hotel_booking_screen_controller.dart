import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../helpers/http/base_client.dart';
import '../../helpers/loginManager/login_manager.dart';

class HotelBookingScreenController {
  Future<dynamic> getSearchHotels(String provinceId, String districtId, String subDistrictId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "").post('/searches/hotels', {
      'province_id': provinceId,
      'district_id': districtId,
      'sub_district_id': subDistrictId,
    })
        .catchError((onError) {
      return onError;
    });
    if (response.runtimeType == int) {
      return response;
    }
    Map dataResponse = await json.decode(response);
    return dataResponse['data'];
  }
}