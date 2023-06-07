import 'dart:convert';

import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';
import '../local_storage_helper.dart';

class FilterManager {
  static final FilterManager _shared = FilterManager._internal();

  factory FilterManager() {
    return _shared;
  }

  FilterManager._internal();

  final UserModel userModel = UserModel();

  Future<Map> filterHotels(
      String provinceId,
      String districtId,
      String subDistrictId,
      String budgetFrom,
      String budgetTo,
      String ratingAverage,
      String amenities,
      String sortById) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).post("/filters/hotels", {
      'province_id': provinceId,
      'district_id': districtId,
      'sub_district_id': subDistrictId,
      "budget_from": budgetFrom,
      "budget_to": budgetTo,
      "rating_average": ratingAverage,
      "amenities": amenities,
      "sort_by_id": sortById,
    }).catchError((err) {
      return err;
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

  Future<Map> filterReviews(
    String hotelId,
    String typeId,
    String sortById,
    String starRating,
  ) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).post("/filters/reviews", {
      "hotel_id": hotelId,
      "type_id": typeId,
      "sort_by_id": sortById,
      "star_rating": starRating,
    }).catchError((err) {
      return err;
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
    if (response.runtimeType != String) {
      resultmap['result'] = '$response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    return dataResponse;
  }
}
