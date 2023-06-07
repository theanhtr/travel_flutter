import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';

class TypeRoomController {
  Future<List<RoomModel>> getAllTypeRoom() async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .get('/my-hotel/type-rooms')
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
      return [];
    }
    if (response.runtimeType == int) {
      debugPrintStack(label: "error get to /my-hotel/type-rooms $response");
      return [];
    }
    Map dataResponse = await json.decode(response);
    var listRoom = dataResponse['data'] as List;
    List<RoomModel> resultListRoom = [];
    for (var element in listRoom) {
      var listService = element['amenities'] as List;
      List<String> services = [];
      List<int> amenitiesResults = [];
      for (var service in listService) {
        services.add(service['name']);
        amenitiesResults.add(service['id'] - 1);
      }
      String? imagePath;
      int? imageId;
      await getTypeRoomImage(element['id']).then((value) => {
            if (value['success'] && value['data'].length > 0)
              {
                imagePath = value['data'][0]['path'],
                imageId = value['data'][0]['id'],
              }
          });
      resultListRoom.add(RoomModel(
        id: element['id'],
        name: element['name'],
        description: element['description'],
        price: element['price'],
        occupancy: element['occupancy'],
        numberOfBeds: element['number_of_beds'],
        size: element['room_size'],
        services: services,
        amenitiesResults: amenitiesResults,
        imagePath: imagePath,
        countAvailabilityRoom: element['room_quantity'],
        imageId: imageId,
      ));
    }
    return resultListRoom;
  }

  Future<Map> getTypeRoomImage(int typeRoomId) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .get('/my-hotel/type-rooms/$typeRoomId/images')
        .catchError((onError) {
      return onError;
    });
    Map resultmap = Map<String, String>();
    if (response == null) {
      resultmap['result'] = 'null response';
      return resultmap;
    }
    if (response.runtimeType == int) {
      debugPrintStack(
          label:
              "error get to /my-hotel/type-rooms/$typeRoomId/images $response");
      resultmap['result'] = 'statuscode $response';
      return resultmap;
    }
    if (response.runtimeType != String) {
      resultmap['result'] = '$response';
      return resultmap;
    }
    Map dataResponse = await json.decode(response);
    return dataResponse;
  }

  Future<bool> deleteTypeRoom(int id) async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .delete('/my-hotel/type-rooms', id.toString())
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
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
