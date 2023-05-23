import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/hotel_model.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';

import '../http/base_client.dart';

class HotelOwnerManager {
  static final HotelOwnerManager _shared = HotelOwnerManager._internal();
  List<dynamic> _amenityList = [];
  List<dynamic> _typeRoomList = [];
  List<dynamic> _myHotelList = [];
  HotelModel myHotelModel = new HotelModel();
  factory HotelOwnerManager() {
    return _shared;
  }

  HotelOwnerManager._internal();
  List<dynamic> get getListAmenities {
    return _amenityList;
  }

  List<dynamic> get getMyHotel {
    return _myHotelList;
  }

  List<dynamic> get getTypeRoomList {
    return _typeRoomList;
  }

  HotelModel get getMyhotelModel {
    return myHotelModel;
  }

  void setMyHotelList(List<dynamic> _myHotelList1) {
    _myHotelList = _myHotelList1;
  }

  void setListAmenities(List<dynamic> _myAmenityList) {
    _amenityList = _myAmenityList;
  }

  void setTypeRoomList(List<dynamic> _myTyperoomList) {
    _typeRoomList = _myTyperoomList;
  }

  void setMyhotelModel(HotelModel myHotelModell) {
    myHotelModel = myHotelModell;
  }

  Future<Map> deleteHotel() async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;

    final response =
        await BaseClient(token!).deleteMyhotel("/my-hotel").catchError((err) {
      debugPrint(err.toString());
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

  Future<Map> deleteImageHotel(String idList) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;

    final response = await BaseClient(token!)
        .deleteHotelIamge("/my-hotel/images", idList)
        .catchError((err) {
      debugPrint(err.toString());
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

  Future<Map> deleteAmenities(String amenities) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!)
        .deleteAmenities("/my-hotel/amenities", amenities)
        .catchError((err) {
      debugPrint("loi delete user: $err");
      return false;
    });
    debugPrint("loi 58: $response");
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

  Future<Map> viewAllAmenities() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token!).get("/my-hotel/amenities").catchError((err) {
      debugPrint(err.toString());
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    // debugPrint('List hotel dong 44 admin manager: ${dataResponse}');
    _amenityList = [];
    _amenityList = dataResponse['data'];
    return dataResponse;
  }

  Future<Map> getAllTypeRoom() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token!).get("/my-hotel/type-rooms").catchError((err) {
      debugPrint(err.toString());
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    // debugPrint('List user dong 101: ${dataResponse}');
    _typeRoomList = [];
    _typeRoomList = dataResponse['data'];
    return dataResponse;
  }

  Future<Map> getHotel() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token!).get("/my-hotel").catchError((err) {
      debugPrint(err.toString());
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    print("dong 128");
    print(dataResponse['data']['hotel']);
    _myHotelList = [];
    _myHotelList = [dataResponse['data']['hotel']];

    return dataResponse;
  }

  Future<Map> getHotelImage() async {
    // print("token day: ${LocalStorageHelper.getValue("userToken")}");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!)
        .get("/users/my-hotel/images")
        .catchError((err) {
      debugPrint(err.toString());
      return false;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    // debugPrint('List hotel dong 44 admin manager: ${dataResponse}');

    return dataResponse;
  }

  Future<Map> addAmenities(String amenities) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).postHaiAnhDung(
        "/my-hotel/amenities", {"amenities": amenities}).catchError((err) {
      debugPrint(err.toString());
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

  Future<Map> createHotels(
    String provinceId,
    String districtId,
    String subDistrictId,
    String name,
    String description,
    String specific_address,
  ) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).postHaiAnhDung("/my-hotel", {
      'province_id': provinceId,
      'district_id': districtId,
      'sub_district_id': subDistrictId,
      // "budget_from": budgetFrom,
      // "budget_to": budgetTo,
      // "rating_average": ratingAverage,
      // "amenities": amenities,
      // "sort_by_id": sortById,
      'name': name,

      'description': description,

      'specific_address': specific_address,
    }).catchError((err) {
      return err;
    });
    print("dong 199");
    print(response);
    Map resultmap = Map<String, String>();
    if (response.runtimeType == int) {
      resultmap['result'] = '$response';
      print("dong 202: $response");
      return resultmap;
    }
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    Map dataResponse = json.decode(response);
    return dataResponse;
  }

  Future<Map> updateHotels(
      String provinceId,
      String districtId,
      String subDistrictId,
      String name,
      String description,
      String specific_address,
      bool change_address) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token!).put("/my-hotel", {
      'province_id': provinceId,
      'district_id': districtId,
      'sub_district_id': subDistrictId,
      // "budget_from": budgetFrom,
      // "budget_to": budgetTo,
      // "rating_average": ratingAverage,
      // "amenities": amenities,
      // "sort_by_id": sortById,
      'name': name,
      'description': description,
      'specific_address': specific_address,
      'change_address': change_address,
    }).catchError((err) {
      return err;
    });
    print("dong 277");
    print(response);
    Map resultmap = Map<String, String>();
    if (response.runtimeType == int) {
      resultmap['result'] = '$response';
      print("dong 202: $response");
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
