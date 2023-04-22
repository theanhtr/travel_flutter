import 'dart:convert';

import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

class SearchYourDestinationScreenController {
  Future<dynamic> getProvince() async {
    var response = await BaseClient(LoginManager().userModel.token ?? "").get('/addresses/provinces')
        .catchError((onError) {
          return onError;
    });
    if (response == null) {
      return false;
    }
    Map dataResponse = await json.decode(response);
    return dataResponse['data'];
  }

  Future<dynamic> getDistricts(String provinceId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "").get('/addresses/$provinceId/districts')
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
      return false;
    }
    Map dataResponse = await json.decode(response);
    return dataResponse['data'];
  }

  Future<dynamic> getSubDistricts(String districtId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "").get('/addresses/$districtId/sub-districts')
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
      return false;
    }
    Map dataResponse = await json.decode(response);
    return dataResponse['data'];
  }

}
