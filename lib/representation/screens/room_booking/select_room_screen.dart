import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/core/utils/navigation_utils.dart';
import 'package:travel_app_ytb/helpers/date_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/representation/screens/checkout/checkout_screen.dart';
import 'package:travel_app_ytb/representation/screens/room_booking/select_room_controller.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/room_card_widget.dart';

import '../../../core/constants/dismention_constants.dart';

class SelectRoomScreen extends StatefulWidget {
  const SelectRoomScreen({super.key});

  static const String routeName = '/select_room_screen';

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  // List<RoomModel> listRooms = [
  //   RoomModel(
  //     name: "vip",
  //     size: 21,
  //     services: ['Free wifi'],
  //     price: 10,
  //     countAvailabilityRoom: 5,
  //   )
  // ];
  List<RoomModel> listRooms = [];

  SelectRoomController? _controller;
  String _dateSelected = "";
  int _guestCount = 1;
  int _roomCount = 1;
  int _hotelId = 0;
  bool _isLoaded = false;

  void _initData() {
    List<String> listDateString = _dateSelected.split(' - ');
    DateHelper dateHelper = DateHelper();
    dateHelper.convertSelectDateOnHotelBookingScreenToDateTime(_dateSelected);
    var dateTime = DateTime.now();
    dateTime = dateTime.add(
      const Duration(
        minutes: 15,
      ),
    );
    var startDate = dateHelper.convertDateString(
        inputFormat: 'HH mm dd MMM yyyy',
        outputFormat: 'HH:mm MM/dd/yy',
        dateString:
            "${dateTime.hour} ${dateTime.minute} ${listDateString[0]} ${(dateHelper.getEndDate()?.year.toString() ?? "2023")}");
    var endDate = dateHelper.convertDateString(
      inputFormat: 'HH mm dd MMM yyyy',
      outputFormat: 'HH:mm MM/dd/yy',
      dateString: "23 59 ${listDateString[1]}",
    );
    if (_isLoaded == false) {
      _controller
          ?.getRoomFromHotel(
              startDate, endDate, _guestCount, _roomCount, _hotelId)
          .then((value) => {
                _isLoaded = true,
                setState(() {
                  listRooms = value;
                }),
              });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = SelectRoomController();
  }

  @override
  Widget build(BuildContext context) {
    var args = NavigationUtils.getArguments(context);
    _hotelId = args["hotelId"];
    _dateSelected = args['dateSelected'];
    _guestCount = args['guestCount'];
    _roomCount = args['roomCount'];
    _initData();
    return AppBarContainer(
      titleString: LocalizationText.selectRoom,
      implementLeading: true,
      child: _isLoaded == false
          ? const SpinKitCircle(
              color: Colors.black,
              size: 64.0,
            )
          : listRooms.isNotEmpty == true
              ? SingleChildScrollView(
                  child: Column(
                    children: List.generate(listRooms.length, (index) {
                      return Column(
                        children: [
                          RoomCardWidget(
                            widthContainer:
                                MediaQuery.of(context).size.width * 0.9,
                            imageFilePath: listRooms[index].imagePath ??
                                ConstUtils.imgHotelDefault,
                            name: listRooms[index].name ?? "vip",
                            roomSize: listRooms[index].size ?? 21,
                            services: listRooms[index].services ?? [],
                            priceInfo: listRooms[index].price ?? 10,
                            roomCount:
                                listRooms[index].countAvailabilityRoom ?? 0,
                            ontap: () {
                              Navigator.pushNamed(
                                context,
                                CheckoutScreen.routeName,
                                arguments: {
                                  "room_selected": listRooms[index],
                                  "hotel_id": _hotelId,
                                  "date_selected": _dateSelected,
                                  "guest_count": _guestCount,
                                  "room_count": _roomCount,
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: kDefaultPadding * 2,
                          ),
                        ],
                      );
                    }),
                  ),
                )
              : const Center(
                  child: Text(
                    'Room hotel list is empty',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
    );
  }
}
