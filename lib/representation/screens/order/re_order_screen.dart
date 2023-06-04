import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/extensions/date_ext.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/hotel_booking_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/checkout/checkout_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_date_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_guest_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/room_booking/select_room_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

import '../../../core/utils/navigation_utils.dart';

class ReOrderScreen extends StatefulWidget {
  const ReOrderScreen({super.key, this.useImplementLeading = true});

  static const String routeName = '/re_order_screen';

  final bool useImplementLeading;

  @override
  State<ReOrderScreen> createState() => _ReOrderScreenState();
}

class _ReOrderScreenState extends State<ReOrderScreen> {
  String? _dateSelected;
  int? _guestCount = 1;
  int? _roomCount = 1;
  HotelBookingScreenController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = HotelBookingScreenController();
    LocationHelper().requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = NavigationUtils.getArguments(context);
    final id = args['hotelId'] as int;

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
                  title: 'Book',
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
                      NavigationUtils.navigate(context, SelectRoomScreen.routeName,
                          arguments: {
                            "hotelId": id,
                            'dateSelected': _dateSelected,
                            'guestCount': _guestCount,
                            'roomCount': _roomCount,
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
