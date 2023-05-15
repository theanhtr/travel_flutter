import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/date_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/info_card.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';

import '../../../helpers/image_helper.dart';
import '../../widgets/booking_hotel_tab_container.dart';
import '../../widgets/room_card_widget.dart';
import 'checkout_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {Key? key, required this.roomSelect, required this.dateSelected, this.isPaymentSuccess, required this.roomCount})
      : super(key: key);
  final RoomModel roomSelect;
  final String dateSelected;
  final int roomCount;
  final Function(bool?)? isPaymentSuccess;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    DateHelper dateHelper = DateHelper();
    dateHelper
        .convertSelectDateOnHotelBookingScreenToDateTime(widget.dateSelected);
    DateTime? startDate = dateHelper.getStartDate();
    DateTime? endDate = dateHelper.getEndDate();
    int countNight = (endDate?.day ?? 1) - (startDate?.day ?? 1) + 1;
    int total = (widget.roomSelect.price ?? 1) * countNight * widget.roomCount;
    return ListView(
      children: [
        _RoomCardInPaymentWidget(
          widthContainer: MediaQuery.of(context).size.width * 0.9,
          imageFilePath:
              widget.roomSelect.imagePath ?? ConstUtils.imgHotelDefault,
          name: widget.roomSelect.name ?? "",
          roomSize: widget.roomSelect.size ?? 21,
          services: widget.roomSelect.services ?? [],
          priceInfo: widget.roomSelect.price ?? 10,
          roomCount: widget.roomSelect.countAvailabilityRoom ?? 1,
          numberOfBed: widget.roomSelect.numberOfBeds ?? 0,
          dateSelected: widget.dateSelected,
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding),
            color: const Color.fromARGB(255, 231, 234, 244),
          ),
          child: Column(children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      countNight <= 1 ? "$countNight night" : "$countNight nights",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      widget.roomCount <= 1 ? "${widget.roomCount} room" : "${widget.roomCount} rooms",
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(
                    "Total:",
                    textAlign: TextAlign.end,
                    style: TextStyles.defaultStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "\$$total",
                  style: TextStyles.defaultStyle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ]),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ButtonWidget(
          title: LocalizationText.payment,
          ontap: () async {
            await makePayment("$total");
          },
        ),
      ],
    );
  }

  Future<void> makePayment(String total) async {
    try {
      paymentIntent = await createPaymentIntent(total, 'usd');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "usd", testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret:
                  paymentIntent!['client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Flutter Stripe Store Demo',
              googlePay: gpay,
            ),
          )
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      debugPrint("$err");
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        widget.isPaymentSuccess?.call(true);
        // todo Call api backend save success payment
        //
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${ConstUtils.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

class _RoomCardInPaymentWidget extends StatelessWidget {
  const _RoomCardInPaymentWidget({
    required this.widthContainer,
    required this.imageFilePath,
    required this.name,
    required this.roomSize,
    required this.priceInfo,
    required this.services,
    this.roomCount = 0,
    this.numberOfBed = 0,
    required this.dateSelected,
  });

  final double widthContainer;
  final String imageFilePath;
  final String name;
  final int roomSize;
  final int priceInfo;
  final List<String> services;
  final int roomCount;
  final int numberOfBed;
  final String dateSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(kDefaultPadding),
      width: widthContainer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: const Color.fromARGB(255, 231, 234, 244),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.defaultStyle.bold.blackTextColor
                      .setTextSize(kDefaultTextSize * 1.2),
                ),
                const SizedBox(
                  height: kItemPadding,
                ),
                Text(
                  'Room Size: $roomSize m2',
                  style: TextStyles.defaultStyle.light.blackTextColor
                      .setTextSize(kDefaultTextSize / 1.2),
                ),
                Row(
                  children: [
                    ImageHelper.loadFromAsset(
                      AssetHelper.bedIcon,
                      width: 20,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      numberOfBed <= 1
                          ? '$numberOfBed ${LocalizationText.bedRoom}'
                          : '$numberOfBed ${LocalizationText.bedsRoom}',
                      style: TextStyles.defaultStyle.light.blackTextColor
                          .setTextSize(kDefaultTextSize),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
            ImageHelper.loadFromNetwork(
              imageFilePath,
              fit: BoxFit.contain,
              radius: BorderRadius.circular(kDefaultPadding),
              width: 60,
              height: 60,
            ),
          ],
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        const Divider(
          color: Color.fromARGB(255, 123, 22, 22),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  ImageHelper.loadFromAsset(
                    AssetHelper.checkInIcon,
                    height: 32,
                    width: 32,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        "Check-in",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 12,
                          color: const Color.fromRGBO(99, 99, 99, 1),
                        ),
                      ),
                      Text(
                        dateSelected.split(' - ').first,
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(49, 49, 49, 1),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  ImageHelper.loadFromAsset(
                    AssetHelper.checkOutIcon,
                    height: 32,
                    width: 32,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        "Check-out",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 12,
                          color: const Color.fromRGBO(99, 99, 99, 1),
                        ),
                      ),
                      Text(
                        dateSelected.split(' - ')[1],
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(49, 49, 49, 1),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
