import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
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
  var isBookingFlightsScreen = true;
  var isBookingFlightsRoundTripScreen = false;
  var isBookingFlightsMultiCityScreen = false;

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: LocalizationText.bookFlight,
      implementLeading: true,
      child: Container(
        margin: const EdgeInsets.only(top: kMediumPadding * 3),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: OutButtonWidget(
                    title: LocalizationText.oneWay,
                    ontap: () {
                      setState(() {
                        isBookingFlightsScreen = true;
                        isBookingFlightsRoundTripScreen = false;
                        isBookingFlightsMultiCityScreen = false;
                      });
                    },
                    backgroundColor:
                        isBookingFlightsScreen ? Colors.orange : null,
                  ),
                ),
                const SizedBox(
                  width: kItemPadding,
                ),
                Expanded(
                  child: OutButtonWidget(
                    title: LocalizationText.roundTrip,
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
                    title: LocalizationText.multiCity,
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
              ],
            ),
            const SizedBox(
              height: kMediumPadding,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: isBookingFlightsScreen
                    ? Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.locationDot,
                                    title: LocalizationText.from,
                                    description: 'Jakarta',
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: AssetHelper.flightIcon,
                                    useIconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.locationDot,
                                    title: LocalizationText.to,
                                    description: 'Surabaya',
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
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
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
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
                                title: LocalizationText.departure,
                                description: LocalizationText.departure,
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
                                title: LocalizationText.passenger,
                                description:
                                    '1 ${LocalizationText.passengerIT}',
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
                                title: LocalizationText.classh,
                                description: LocalizationText.economy,
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
                                title: LocalizationText.search,
                                ontap: () {},
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                            ],
                          )
                        ],
                      )
                    : isBookingFlightsRoundTripScreen
                        ? Column(
                            children: [
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      BookingHotelTab(
                                        icon: FontAwesomeIcons.locationDot,
                                        title: LocalizationText.from,
                                        description: 'Jakarta',
                                        sizeItem: kDefaultIconSize,
                                        sizeText: kDefaultIconSize / 1.2,
                                        primaryColor: const Color(0xffFE9C5E),
                                        secondaryColor: const Color(0xffFE9C5E)
                                            .withOpacity(0.2),
                                        iconString: AssetHelper.flightIcon,
                                        useIconString: '',
                                      ),
                                      const SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      BookingHotelTab(
                                        icon: FontAwesomeIcons.locationDot,
                                        title: LocalizationText.to,
                                        description: 'Surabaya',
                                        sizeItem: kDefaultIconSize,
                                        sizeText: kDefaultIconSize / 1.2,
                                        primaryColor: const Color(0xffFE9C5E),
                                        secondaryColor: const Color(0xffFE9C5E)
                                            .withOpacity(0.2),
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
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kMediumPadding),
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
                                    title: LocalizationText.departure,
                                    description: LocalizationText.departure,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.calendarDay,
                                    title: LocalizationText.returnn,
                                    description: LocalizationText.departure,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.solidUser,
                                    title: LocalizationText.passenger,
                                    description:
                                        '1 ${LocalizationText.passengerIT}',
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.locationDot,
                                    title: LocalizationText.classh,
                                    description: LocalizationText.economy,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: AssetHelper.seatIcon,
                                    useIconString: '',
                                    bordered: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  ButtonWidget(
                                    title: LocalizationText.search,
                                    ontap: () {},
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                ],
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${LocalizationText.flight} 1',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      BookingHotelTab(
                                        icon: FontAwesomeIcons.locationDot,
                                        title: LocalizationText.from,
                                        description: 'Jakarta',
                                        sizeItem: kDefaultIconSize,
                                        sizeText: kDefaultIconSize / 1.2,
                                        primaryColor: const Color(0xffFE9C5E),
                                        secondaryColor: const Color(0xffFE9C5E)
                                            .withOpacity(0.2),
                                        iconString: AssetHelper.flightIcon,
                                        useIconString: '',
                                      ),
                                      const SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      BookingHotelTab(
                                        icon: FontAwesomeIcons.locationDot,
                                        title: LocalizationText.to,
                                        description: 'Surabaya',
                                        sizeItem: kDefaultIconSize,
                                        sizeText: kDefaultIconSize / 1.2,
                                        primaryColor: const Color(0xffFE9C5E),
                                        secondaryColor: const Color(0xffFE9C5E)
                                            .withOpacity(0.2),
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
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kMediumPadding),
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
                                    title: LocalizationText.departure,
                                    description: LocalizationText.departure,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.solidUser,
                                    title: LocalizationText.passenger,
                                    description:
                                        '1 ${LocalizationText.passenger}',
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.locationDot,
                                    title: LocalizationText.classh,
                                    description: LocalizationText.economy,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: AssetHelper.seatIcon,
                                    useIconString: '',
                                    bordered: '',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                '${LocalizationText.flight}  2',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      BookingHotelTab(
                                        icon: FontAwesomeIcons.locationDot,
                                        title: LocalizationText.from,
                                        description: 'Jakarta',
                                        sizeItem: kDefaultIconSize,
                                        sizeText: kDefaultIconSize / 1.2,
                                        primaryColor: const Color(0xffFE9C5E),
                                        secondaryColor: const Color(0xffFE9C5E)
                                            .withOpacity(0.2),
                                        iconString: AssetHelper.flightIcon,
                                        useIconString: '',
                                      ),
                                      const SizedBox(
                                        height: kDefaultPadding,
                                      ),
                                      BookingHotelTab(
                                        icon: FontAwesomeIcons.locationDot,
                                        title: LocalizationText.to,
                                        description: 'Surabaya',
                                        sizeItem: kDefaultIconSize,
                                        sizeText: kDefaultIconSize / 1.2,
                                        primaryColor: const Color(0xffFE9C5E),
                                        secondaryColor: const Color(0xffFE9C5E)
                                            .withOpacity(0.2),
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
                                        padding: const EdgeInsets.all(
                                            kDefaultPadding),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kMediumPadding),
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
                                    title: LocalizationText.departure,
                                    description: LocalizationText.departure,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.solidUser,
                                    title: LocalizationText.passenger,
                                    description:
                                        '1 ${LocalizationText.passengerIT}',
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.locationDot,
                                    title: LocalizationText.classh,
                                    description: LocalizationText.economy,
                                    sizeItem: kDefaultIconSize,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: AssetHelper.seatIcon,
                                    useIconString: '',
                                    bordered: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  ButtonWidget(
                                    title: LocalizationText.search,
                                    ontap: () {},
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                ],
                              ),
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
