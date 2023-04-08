import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/screens/search_hotels_screen.dart';
import 'package:travel_app_ytb/representation/screens/select_date_screen.dart';
import 'package:travel_app_ytb/representation/screens/select_guest_room_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/core/extensions/date_ext.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  static const String routeName = '/hotel_booking_screen';

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? dateSelected;
  int? guestCount = 1;
  int? roomCount = 1;

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Hotel Booking',
      // ignore: sort_child_properties_last
      child: Container(
          child: SingleChildScrollView(
        // ignore: prefer_const_literals_to_create_immutables
        child: Column(children: [
          // ignore: prefer_const_constructors
          SizedBox(
            height: kMediumPadding * 2,
          ),
          BookingHotelTab(
            icon: FontAwesomeIcons.locationDot,
            title: 'Destination',
            description: 'South Korea',
            sizeItem: kDefaultIconSize,
            sizeText: kDefaultIconSize / 1.2,
            primaryColor: const Color(0xffFE9C5E),
            secondaryColor: const Color(0xffFE9C5E).withOpacity(0.2),
            iconString: '',
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: StatefulBuilder(builder: (context, setState) {
              return BookingHotelTab(
                icon: FontAwesomeIcons.calendarDay,
                title: 'Select Date',
                description: dateSelected ?? 'Please select date',
                sizeItem: kDefaultIconSize,
                sizeText: kDefaultIconSize / 1.2,
                primaryColor: const Color(0xffF77777),
                secondaryColor: const Color(0xffF77777).withOpacity(0.2),
                implementSetting: true,
                ontap: () async {
                  final result = await Navigator.pushNamed(
                      context, SelectDateScreen.routeName,
                      arguments: {'oldDate': dateSelected});
                  if (!(result as List<DateTime?>)
                      .any((element) => element == null)) {
                    dateSelected =
                        '${result[0]?.getStartDate} - ${result[1]?.getEndDate}';
                    setState(() {});
                  }
                },
                iconString: '',
              );
            }),
          ),
          BookingHotelTab(
            icon: FontAwesomeIcons.bed,
            title: 'Guest and Room',
            description: '$guestCount Guest, $roomCount Room',
            sizeItem: kDefaultIconSize,
            sizeText: kDefaultIconSize / 1.2,
            primaryColor: const Color(0xff3EC8BC),
            secondaryColor: const Color(0xff3EC8BC).withOpacity(0.2),
            implementSetting: true,
            ontap: () async {
              final result = await Navigator.pushNamed(
                  context, SelectGuestRoomScreen.routeName,
                  arguments: {
                    'guestCount': guestCount,
                    'roomCount': roomCount,
                  });

              if (!(result as List<int?>).any((element) => element == null)) {
                guestCount = result[0];
                roomCount = result[1];
                setState(() {});
              }
            },
            iconString: '',
          ),
          Container(
            margin: const EdgeInsets.only(top: kDefaultPadding),
            child: ButtonWidget(
              title: 'Search',
              ontap: () {
                if (dateSelected == null) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.topSlide,
                    title: "Hey, check all again!",
                    desc:
                        "Maybe you haven't filled in one of the fields, please complete it :33",
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  Navigator.pushNamed(context, SearchHotelsScreen.routeName);
                }
              },
            ),
          ),
        ]),
      )),
      implementLeading: true,
    );
  }
}
