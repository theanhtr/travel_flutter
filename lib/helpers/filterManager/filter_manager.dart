import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';

class FilterManager {
  static final FilterManager _shared = FilterManager._internal();

  factory FilterManager() {
    return _shared;
  }

  FilterManager._internal();

  final UserModel userModel = UserModel();

  Future<Map> filterHotels(String budgetFrom, String budgetTo, String ratingAverage) async {
    final response = await BaseClient("").post("/filters/hotels", {
      "budget_from": budgetFrom,
      "budget_to": budgetTo,
      "rating_average": ratingAverage,
    }).catchError((err) {
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

}
