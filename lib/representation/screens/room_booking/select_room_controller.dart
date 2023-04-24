import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';

import '../../../helpers/http/base_client.dart';
import '../../../helpers/loginManager/login_manager.dart';

class SelectRoomController {
  Future<List<RoomModel>> getRoomFromHotel(
      String checkInDate,
      String checkOutDate,
      int guestQuantity,
      int roomQuantity,
      int hotelId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .post('/searches/type-rooms', {
      "check_in_date": checkInDate,
      "check_out_date": checkOutDate,
      "guest_quantity": guestQuantity,
      "room_quantity": roomQuantity,
      "hotel_id": hotelId,
    }).catchError((onError) {
      return onError;
    });
    if (response == null) {
      return [];
    }
    if (response.runtimeType == int) {
      debugPrintStack(
          label:
              "error post to /searches/type-rooms $response $checkInDate $guestQuantity, $roomQuantity, $hotelId");
      return [];
    }
    Map dataResponse = await json.decode(response);
    var listRoom = dataResponse['data'] as List;
    List<RoomModel> resultListRoom = [];
    for (var element in listRoom) {
      var listService = element['amenities'] as List;
      List<String> services = [];
      for (var service in listService) {
          services.add(service['name']);
      }
      var imagePaths = element['images'] as List;
      resultListRoom.add(RoomModel(
        id: element['id'],
        name: element['name'],
        description: element['description'],
        price: element['price'],
        occupancy: element['occupancy'],
        numberOfBeds: element['number_of_beds'],
        countAvailabilityRoom: element['count_availablity_room'],
        size: element['room_size'],
        imagePath: imagePaths.isEmpty == true ? ConstUtils.imgHotelDefault : imagePaths.first['path'],
        services: services,
      ));
    }
    return resultListRoom;
  }
}
