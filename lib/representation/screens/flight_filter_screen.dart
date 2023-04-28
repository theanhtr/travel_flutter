import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/out_button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/slider.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class FlightFilterScreen extends StatefulWidget {
  const FlightFilterScreen({super.key});
  static const String routeName = '/hotel_filter_screen';
  @override
  State<FlightFilterScreen> createState() => _FlightFilterScreenState();
}

class _FlightFilterScreenState extends State<FlightFilterScreen> {
  SampleItem? selectedMenu;
  var isBookingFlightsScreen = true;
  var isBookingFlightsRoundTripScreen = false;
  var isBookingFlightsMultiCityScreen = false;
  @override
  Widget build(BuildContext context) {
    String msg = 'Flutter RaisedButton Example';
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter RaisedButton Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: style,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ButtonInDialog();
                      });
                },
                child: Text("Open Popup"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonInDialog extends StatefulWidget {
  const ButtonInDialog({super.key});

  @override
  State<ButtonInDialog> createState() => _ButtonInDialogState();
}

class _ButtonInDialogState extends State<ButtonInDialog> {
  var isBookingFlightsScreen = true;
  var isBookingFlightsRoundTripScreen = false;
  var isBookingFlightsMultiCityScreen = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(239, 255, 255, 229),
      scrollable: true,
      title: Text(
        LocalizationText.choseFilter,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: OutButtonWidget(
                title: LocalizationText.direct,
                ontap: () {
                  setState(() {
                    isBookingFlightsScreen = true;
                    isBookingFlightsRoundTripScreen = false;
                    isBookingFlightsMultiCityScreen = false;
                  });
                },
                backgroundColor: isBookingFlightsScreen ? Colors.orange : null,
              ),
            ),
            const SizedBox(
              width: kItemPadding,
            ),
            Expanded(
              child: OutButtonWidget(
                title: LocalizationText.transit_1,
                ontap: () {
                  setState(() {
                    isBookingFlightsScreen = false;
                    isBookingFlightsRoundTripScreen = true;
                    isBookingFlightsMultiCityScreen = false;
                  });
                },
                backgroundColor:
                    isBookingFlightsRoundTripScreen ? Colors.orange : null,
              ),
            ),
            const SizedBox(
              width: kItemPadding,
            ),
            Expanded(
              child: OutButtonWidget(
                title: LocalizationText.transit_2_plus,
                ontap: () {
                  setState(() {
                    isBookingFlightsScreen = false;
                    isBookingFlightsRoundTripScreen = false;
                    isBookingFlightsMultiCityScreen = true;
                  });
                },
                backgroundColor:
                    isBookingFlightsMultiCityScreen ? Colors.orange : null,
              ),
            ),
          ]),
          const SizedBox(
            height: kMediumPadding,
          ),
          Row(
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    LocalizationText.transit,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const MySliderApp(
                    initialFontSize: 20,
                    start: 0,
                    end: 10,
                    unit: "\H",
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Row(
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    LocalizationText.transit,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const MySliderApp(
                    initialFontSize: 20,
                    start: 0,
                    end: 1000,
                    unit: "\$",
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: kMediumPadding,
          ),
          Column(children: [
            BookingHotelTab(
              icon: FontAwesomeIcons.suitcaseMedical,
              title: LocalizationText.facilities,
              description: '',
              sizeItem: kDefaultIconSize / 1.5,
              sizeText: kDefaultIconSize / 1.2,
              primaryColor: const Color(0xffFE9C5E),
              secondaryColor: const Color(0xffFE9C5E).withOpacity(0.2),
              iconString: '',
            ),
            const SizedBox(
              height: kMinPadding,
            ),
            BookingHotelTab(
              icon: FontAwesomeIcons.sort,
              title: LocalizationText.sortBy,
              description: "",
              sizeItem: kDefaultIconSize / 1.5,
              sizeText: kDefaultIconSize / 1.2,
              primaryColor: Color.fromARGB(255, 113, 228, 155),
              secondaryColor:
                  Color.fromARGB(255, 126, 235, 193).withOpacity(0.2),
              iconString: 'id',
            ),
          ]),
        ]),
      ),
      actions: [
        Container(
          // margin: const EdgeInsets.only(top: kMediumPadding),

          child: Column(
            children: [
              ButtonWidget(
                title: LocalizationText.apply,
                ontap: () {},
              ),
              const SizedBox(
                height: kMinPadding,
              ),
              ButtonWidget(
                title: LocalizationText.reset,
                ontap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
