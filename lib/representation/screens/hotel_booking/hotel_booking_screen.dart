import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/hotel_booking_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/search_your_destination_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/search_hotels_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_date_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_guest_room_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/core/extensions/date_ext.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key, this.useImplementLeading = true});

  static const String routeName = '/hotel_booking_screen';

  final bool useImplementLeading;

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String? _dateSelected;
  int? _guestCount = 1;
  int? _roomCount = 1;
  Map<String, dynamic>? _selectedProvinceValue;
  Map<String, dynamic>? _selectedDistrictValue;
  Map<String, dynamic>? _selectedSubDistrictValue;
  HotelBookingScreenController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = HotelBookingScreenController();
    LocationHelper().requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: LocalizationText.hotelBooking,
      implementLeading: widget.useImplementLeading,
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
            title: LocalizationText.destination,
            description: _selectedDistrictValue?.isEmpty == false
                ? "${_selectedProvinceValue?['name'] ?? ""}, ${_selectedDistrictValue?['name'] ?? ""}, ${_selectedSubDistrictValue?['name'] ?? ""}"
                : "",
            sizeItem: kDefaultIconSize,
            sizeText: kDefaultIconSize / 1.2,
            primaryColor: const Color(0xffFE9C5E),
            secondaryColor: const Color(0xffFE9C5E).withOpacity(0.2),
            iconString: '',
            ontap: () async {
              final result = await Navigator.pushNamed(
                  context, SearchYourDestinationScreen.routeName,
                  arguments: {
                    'selectedProvinceValue': _selectedProvinceValue,
                    'selectedDistrictValue': _selectedDistrictValue,
                    'selectedSubDistrictValue': _selectedSubDistrictValue,
                  });
              if (!(result as List<Map<String, dynamic>?>)
                  .any((element) => element == null)) {
                _selectedProvinceValue = result[0];
                _selectedDistrictValue = result[1];
                _selectedSubDistrictValue = result[2];
                setState(() {});
              }
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: StatefulBuilder(builder: (context, setState) {
              return BookingHotelTab(
                icon: FontAwesomeIcons.calendarDay,
                title: LocalizationText.selectDate,
                description: _dateSelected ?? LocalizationText.pleaseSelectDate,
                sizeItem: kDefaultIconSize,
                sizeText: kDefaultIconSize / 1.2,
                primaryColor: const Color(0xffF77777),
                secondaryColor: const Color(0xffF77777).withOpacity(0.2),
                implementSetting: true,
                ontap: () async {
                  final result = await Navigator.pushNamed(
                      context, SelectDateScreen.routeName,
                      arguments: {'oldDate': _dateSelected});
                  if (!(result as List<DateTime?>)
                      .any((element) => element == null)) {
                    _dateSelected =
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
            title: LocalizationText.guestAndRoom,
            description:
                '$_guestCount ${LocalizationText.guest}, $_roomCount ${LocalizationText.room}',
            sizeItem: kDefaultIconSize,
            sizeText: kDefaultIconSize / 1.2,
            primaryColor: const Color(0xff3EC8BC),
            secondaryColor: const Color(0xff3EC8BC).withOpacity(0.2),
            implementSetting: true,
            ontap: () async {
              final result = await Navigator.pushNamed(
                  context, SelectGuestRoomScreen.routeName,
                  arguments: {
                    'guestCount': _guestCount,
                    'roomCount': _roomCount,
                  });

              if (!(result as List<int?>).any((element) => element == null)) {
                _guestCount = result[0];
                _roomCount = result[1];
                setState(() {});
              }
            },
            iconString: '',
          ),
          Container(
            margin: const EdgeInsets.only(top: kDefaultPadding),
            child: ButtonWidget(
              title: LocalizationText.search,
              ontap: () {
                if (_dateSelected == null) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.topSlide,
                    title: LocalizationText.checkAll,
                    desc: LocalizationText.fieldsHavenotFill,
                    btnOkOnPress: () {},
                  ).show();
                } else {
                  _controller
                      ?.getSearchHotels(
                          _selectedProvinceValue?['id'].toString() ?? "0",
                          _selectedDistrictValue?['id'].toString() ?? "0",
                          _selectedSubDistrictValue?['id'].toString() ?? "0")
                      .then((value) => {
                            if (value.runtimeType != int)
                              {
                                Navigator.pushNamed(
                                    context, SearchHotelsScreen.routeName,
                                    arguments: {
                                      'listHotels': value,
                                      'dateSelected': _dateSelected,
                                      'guestCount': _guestCount,
                                      'roomCount': _roomCount,
                                      'selectedProvinceValue':
                                          _selectedProvinceValue,
                                      'selectedDistrictValue':
                                          _selectedDistrictValue,
                                      'selectedSubDistrictValue':
                                          _selectedSubDistrictValue,
                                    })
                              }
                          });
                }
              },
            ),
          ),
        ]),
      )),
    );
  }
}
