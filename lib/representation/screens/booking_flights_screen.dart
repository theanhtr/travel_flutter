import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/screens/booking_flights_multi_city_screen.dart';
import 'package:travel_app_ytb/representation/screens/booking_flights_round_trip_screen.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/out_button_widget.dart';

import '../../core/constants/textstyle_constants.dart';
import '../../helpers/asset_helper.dart';
import '../../helpers/image_helper.dart';
import '../widgets/app_bar_container.dart';
import '../widgets/booking_hotel_tab_container.dart';
import '../widgets/item_text_container.dart';

class BookingFlightsScreen extends StatefulWidget {
  const BookingFlightsScreen({Key? key}) : super(key: key);

  static const String routeName = '/booking_flights_screen';

  @override
  State<BookingFlightsScreen> createState() => _BookingFlightsScreenState();
}

class _BookingFlightsScreenState extends State<BookingFlightsScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: '''Book Your Flight''',
      implementLeading: true,
      child: Container(
        margin: const EdgeInsets.only(top: kMediumPadding * 3),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutButtonWidget(
                    title: 'One way',
                    ontap: () {},
                    backgroundColor: Colors.orange,
                  ),
                ),
                const SizedBox(
                  width: kItemPadding,
                ),
                Expanded(
                  child: OutButtonWidget(
                    title: 'Round trip',
                    ontap: () {
                      Navigator.of(context)
                          .pushNamed(BookingFlightsRoundTripScreen.routeName);
                    },
                  ),
                ),
                const SizedBox(
                  width: kItemPadding,
                ),
                Expanded(
                  child: OutButtonWidget(
                    title: 'Multi-City',
                    ontap: () {
                      Navigator.of(context)
                          .pushNamed(BookingFlightsMultiCityScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kMediumPadding,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            BookingHotelTab(
                              icon: FontAwesomeIcons.locationDot,
                              title: 'From',
                              description: 'Jakarta',
                              sizeItem: kDefaultIconSize,
                              sizeText: kDefaultIconSize / 1.2,
                              primaryColor: const Color(0xffFE9C5E),
                              secondaryColor:
                                  const Color(0xffFE9C5E).withOpacity(0.2),
                              iconString: AssetHelper.flightIcon,
                              useIconString: '',
                            ),
                            const SizedBox(
                              height: kDefaultPadding,
                            ),
                            BookingHotelTab(
                              icon: FontAwesomeIcons.locationDot,
                              title: 'To',
                              description: 'Surabaya',
                              sizeItem: kDefaultIconSize,
                              sizeText: kDefaultIconSize / 1.2,
                              primaryColor: const Color(0xffFE9C5E),
                              secondaryColor:
                                  const Color(0xffFE9C5E).withOpacity(0.2),
                              iconString: AssetHelper.locationIcon,
                              useIconString: '',
                            ),
                          ],
                        ),
                        Positioned(
                          right: kMediumPadding,
                          top: kMediumPadding * 3,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kMediumPadding),
                                color: ColorPalette.opacityColor,
                              ),
                              alignment: Alignment.center,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.arrowUpDownIcon),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Column(
                      children: [
                        BookingHotelTab(
                          icon: FontAwesomeIcons.calendarDay,
                          title: 'Departure',
                          description: 'Select Date',
                          sizeItem: kDefaultIconSize,
                          sizeText: kDefaultIconSize / 1.2,
                          primaryColor: const Color(0xffFE9C5E),
                          secondaryColor:
                              const Color(0xffFE9C5E).withOpacity(0.2),
                          iconString: '',
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        BookingHotelTab(
                          icon: FontAwesomeIcons.solidUser,
                          title: 'Passengers',
                          description: '1 Passenger',
                          sizeItem: kDefaultIconSize,
                          sizeText: kDefaultIconSize / 1.2,
                          primaryColor: const Color(0xffFE9C5E),
                          secondaryColor:
                              const Color(0xffFE9C5E).withOpacity(0.2),
                          iconString: '',
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        BookingHotelTab(
                          icon: FontAwesomeIcons.locationDot,
                          title: 'Class',
                          description: 'Economy',
                          sizeItem: kDefaultIconSize,
                          sizeText: kDefaultIconSize / 1.2,
                          primaryColor: const Color(0xffFE9C5E),
                          secondaryColor:
                              const Color(0xffFE9C5E).withOpacity(0.2),
                          iconString: AssetHelper.seatIcon,
                          useIconString: '',
                          bordered: '',
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        ButtonWidget(
                          title: 'Search',
                          ontap: () {},
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
