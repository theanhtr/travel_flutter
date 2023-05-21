import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';

class PaymentManager {
  static final PaymentManager _shared = PaymentManager._internal();

  factory PaymentManager() {
    return _shared;
  }

  PaymentManager._internal();

  Future<Map> createPayment(String name_holder_card, String address_city,
      String number, int exp_month, int exp_year, int cvc, int order_id) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response =
        await BaseClient(token ?? "").postHaiAnhDung("/orders/payment", {
      "name_holder_card": name_holder_card,
      "address_city": address_city,
      "number": number,
      "exp_month": exp_month,
      "exp_year": exp_year,
      "cvc": cvc,
      "order_id": order_id,
    }).catchError((err) {
      debugPrint("hwc hce");
      return false;
    });
    Map dataResponse = Map<String, String>();
    dataResponse = json.decode(response);

    return dataResponse;
  }

  Future<HotelOrderResponseModel> createHotelOrder(
    String customerName,
    String emailContact,
    String phoneNumberContact,
    String customerNote,
    int amountOfPeople,
    int roomQuantity,
    String checkInDate,
    String checkOutDate,
    int typeRoomId,
    int hotelId,
  ) async {
    debugPrint("51 paymentManager $hotelId");
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token ?? "")
        .postHaiAnhDung("/orders/create-hotel-order", {
      "customer_name": customerName,
      "email_contact": emailContact,
      "phone_number_contact": phoneNumberContact,
      "customer_note": customerNote,
      "amount_of_people": amountOfPeople,
      "room_quantity": roomQuantity,
      "check_in_date": checkInDate,
      "check_out_date": checkOutDate,
      "type_room_id": typeRoomId,
      "hotel_id": hotelId
    }).catchError((err) {
      debugPrint("error $err");
      return HotelOrderResponseModel();
    });
    Map dataResponse = json.decode(response);
    return HotelOrderResponseModel(
      success: dataResponse['success'],
      message: dataResponse['message'],
      data: DataOfHotelOrderResponseModel(
        id: dataResponse['data']['id'],
      ),
    );
  }

  Future<HotelOrderResponseModel> paymentClient(int orderId) async {
    final token = await LocalStorageHelper.getValue("userToken") as String?;
    final response = await BaseClient(token ?? "")
        .postHaiAnhDung("/orders/payment-client", {
        'order_id': orderId,
    }).catchError((err) {
      debugPrint("error $err");
      return HotelOrderResponseModel();
    });
    Map dataResponse = json.decode(response);
    return HotelOrderResponseModel(
      success: dataResponse['success'],
      message: dataResponse['message'],
    );
  }
}

class HotelOrderResponseModel {
  bool? success;
  String? message;
  DataOfHotelOrderResponseModel? data;

  HotelOrderResponseModel({this.success, this.message, this.data});
}

class DataOfHotelOrderResponseModel {
  String? customerName;
  String? emailContact;
  int? phoneNumberContact;
  String? customerNote;
  int? totalPrice;
  int? amountOfPeople;
  int? roomQuantity;
  int? id;

  DataOfHotelOrderResponseModel({
    this.customerName,
    this.emailContact,
    this.phoneNumberContact,
    this.customerNote,
    this.totalPrice,
    this.amountOfPeople,
    this.roomQuantity,
    this.id,
  });
}
