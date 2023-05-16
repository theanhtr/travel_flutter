import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:path/path.dart';
import '../http/base_client.dart';

const String baseUrl =
    "https://692c-2405-4802-1d4e-e150-1c0f-4211-9b11-d7bd.ngrok-free.app/api";

class paymentManager {
  static final paymentManager _shared = paymentManager._internal();

  factory paymentManager() {
    return _shared;
  }

  paymentManager._internal();

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
}
