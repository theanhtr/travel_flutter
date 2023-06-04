import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';

import '../../../helpers/http/base_client.dart';

class OrderHistoryController {
  Future<List<OrderHotelModel>> getAllHotelOrder() async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    var response = await BaseClient(token ?? "")
        .get('/orders/get-all-hotel-order')
        .catchError((onError) {
      return onError;
    });
    if (response == null) {
      return [];
    }
    return OrderHotelModel.convertJsonToOrderHotelModel(response);
  }
}

class OrderHotelModel {
  final int? id;
  final String? customerName;
  final String? emailContact;
  final int? phoneNumberContact;
  final String? customerNote;
  final double? totalPrice;
  final int? amountOfPeople;
  final String? timeOrder;
  final int? roomQuantity;
  final String? checkInDate;
  final String? checkOUtDate;
  final int? orderStatusId;
  final String? hotelName;
  final String? typeRoomName;
  final int? typeRoomSize;
  final int? typeRoomNumberOfBeds;
  final int? hotelId;

  const OrderHotelModel({
    this.emailContact,
    this.phoneNumberContact,
    this.customerNote,
    this.totalPrice,
    this.amountOfPeople,
    this.timeOrder,
    this.roomQuantity,
    this.checkInDate,
    this.checkOUtDate,
    this.orderStatusId,
    this.id,
    this.customerName,
    this.hotelName,
    this.typeRoomName,
    this.typeRoomSize,
    this.typeRoomNumberOfBeds,
    this.hotelId,
  });

  static Future<List<OrderHotelModel>> convertJsonToOrderHotelModel(
      dynamic jsonResponse) async {
    Map dataResponse = await json.decode(jsonResponse);
    if (jsonResponse.runtimeType == int) {
      return [];
    }
    if (dataResponse['success'] == true) {
      List<OrderHotelModel> listOrder = [];
      dataResponse['data'].forEach((element) {
        listOrder.add(OrderHotelModel(
          id: element['id'],
          customerName: element['customer_name'],
          emailContact: element['email_contact'],
          phoneNumberContact: element['phone_number_contact'],
          customerNote: element['customer_note'],
          totalPrice: element['total_price'].toDouble(),
          amountOfPeople: element['amount_of_people'],
          timeOrder: element['time_order'],
          roomQuantity: element['room_quantity'],
          checkInDate: element['check_in_date'],
          checkOUtDate: element['check_out_date'],
          orderStatusId: element['order_status_id'],
          hotelName: element['hotel_name'],
          typeRoomName: element['type_room_name'],
          typeRoomSize: element['type_room_size'],
          typeRoomNumberOfBeds: element['type_room_number_of_beds'],
          hotelId: element['hotel_id'],
        ));
      });
      return listOrder;
    }
    return [];
  }
}
