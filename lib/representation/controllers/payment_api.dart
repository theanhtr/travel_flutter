import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/paymentManager/paymentManager.dart';

class PaymentAPI {
  Future<Map> payment(String name_holder_card, String address_city,
      String number, int exp_month, int exp_year, int cvc, int order_id) {
    return paymentManager().createPayment(name_holder_card, address_city,
        number, exp_month, exp_year, cvc, order_id);
  }
}
