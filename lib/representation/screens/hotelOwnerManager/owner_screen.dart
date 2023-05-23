import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/hotelOwnerManager/hotel_owner_manager.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';

import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/admin/add_user_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/drawer_page_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/hotel_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/panelCenter_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/amenity_manager.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/create_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/home_owner_page.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/show_my_hotel.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

class HotelOwnerScreen extends StatefulWidget {
  HotelOwnerScreen({super.key});
  static const String routeName = '/hotel_owner_screen';
  var hotelManager = HotelOwnerManager();
  @override
  State<HotelOwnerScreen> createState() => _HotelOwnerScreenState();
}

enum Section { HOME, ALL_HOTELS, ALL_USER }

class _HotelOwnerScreenState extends State<HotelOwnerScreen> {
  String amenities = "";
  List<int> amenitiesResults = [];
  int section = 0;
  bool isFirst = true;
  bool _isLoading = false;
  bool _canLoadCardView = false;
  int isDone = 0;
  int isDone2 = 0;
  LocationHelper locationHelper = new LocationHelper();
  Map<String, dynamic>? _selectedProvinceValue;
  Map<String, dynamic>? _selectedDistrictValue;
  Map<String, dynamic>? _selectedSubDistrictValue;
  @override
  Widget build(BuildContext context) {
    Function callback = () {
      setState(() {
        isFirst = true;
      });
    };
    // print("isFirst dong 36 $isFirst");
    if (isFirst) {
      locationHelper.requestPermission();
      isFirst = false;
      widget.hotelManager.getAllTypeRoom().then((value) => {
            // print("value1 day $value"),
            widget.hotelManager.viewAllAmenities().then((value) => {
                  // print("value2 day $value"),
                  widget.hotelManager.getHotel().then((value) => {
                        isDone = 1,
                        isDone2 = 1,
                      })
                }),
          });
      setState(() {});
    }
    if (isDone == 1 && isDone2 == 1) {
      print("amenity list");
      // debugPrint(widget.hotelManager.getListAmenities.toString());
      // debugPrint(widget.hotelManager.getTypeRoomList.toString());
      debugPrint(widget.hotelManager.getMyHotel.toString());
      // isFirst = true;
      _isLoading = false;
      _canLoadCardView = false;
    }
    // widget.hotelManager.viewAllHotel();
    debugPrint('${section}');
    Widget body = Scaffold(
      body: Text(LocalizationText.home),
    );

    switch (section) {
      /// Display the home section, simply by
      case 0:
        body = HomeHotelOwnerPage();
        break;
      case 1:
        body = ProfilePage();
        break;
      case 2:
        if (isDone-- > 0) {
          // print("admin hotel ${widget.hotelManager.getListHotel}");
          isFirst = false;
          body = AmenityHotel(
              isdelete: false,
              amenityList: widget.hotelManager.getListAmenities,
              getData: (listCheckboxPosition, amenitiesT) {
                amenities = amenitiesT;
                amenitiesResults = listCheckboxPosition;
              },
              callback: callback);
          isDone = 1;
        } else {
          isFirst = false;
          body = Loading();
        }

        break;
      case 3:
        if (isDone-- > 0) {
          isFirst = false;
          body = AmenityHotel(
              isdelete: true,
              amenityList: widget.hotelManager.getListAmenities,
              getData: (listCheckboxPosition, amenitiesT) {
                amenities = amenitiesT;
                amenitiesResults = listCheckboxPosition;
              },
              callback: callback);
          isDone = 1;
        } else {
          isFirst = false;
          body = Loading();
        }
        break;

      case 4:
        body = MyhotelScreen(
          hotelsList: widget.hotelManager.getMyHotel,
          setSectiond: (index) {
            setState(() {
              section = index;
              isFirst = false;
            });
          },
        );
        break;
      case 5:
        body = Container();
        break;
      case 7:
        // body = BookingHotelTab(
        //   icon: FontAwesomeIcons.locationDot,
        //   title: LocalizationText.destination,
        //   description: _selectedDistrictValue?.isEmpty == false
        //       ? "${_selectedProvinceValue?['name'] ?? ""}, ${_selectedDistrictValue?['name'] ?? ""}, ${_selectedSubDistrictValue?['name'] ?? ""}"
        //       : "",
        //   sizeItem: kDefaultIconSize,
        //   sizeText: kDefaultIconSize / 1.2,
        //   primaryColor: const Color(0xffFE9C5E),
        //   secondaryColor: const Color(0xffFE9C5E).withOpacity(0.2),
        //   iconString: '',
        //   ontap: () async {
        //     final result = await Navigator.pushNamed(
        //         context, CreateHotelScreen.routeName,
        //         arguments: {
        //           'selectedProvinceValue': _selectedProvinceValue,
        //           'selectedDistrictValue': _selectedDistrictValue,
        //           'selectedSubDistrictValue': _selectedSubDistrictValue,
        //           'setSectiond': (index) {
        //             setState(() {
        //               section = index;
        //               isFirst = false;
        //             });
        //           },
        //         });
        //     if (!(result as List<Map<String, dynamic>?>)
        //         .any((element) => element == null)) {
        //       _selectedProvinceValue = result[0];
        //       _selectedDistrictValue = result[1];
        //       _selectedSubDistrictValue = result[2];
        //       setState(() {});
        //     }
        //   },
        // );
        // final result = Navigator.pushNamed(context, CreateHotelScreen.routeName,
        //     arguments: {
        //       'selectedProvinceValue': _selectedProvinceValue,
        //       'selectedDistrictValue': _selectedDistrictValue,
        //       'selectedSubDistrictValue': _selectedSubDistrictValue,
        //     });
        // if (!(result as List<Map<String, dynamic>?>)
        //     .any((element) => element == null)) {
        //   _selectedProvinceValue = result[0];
        //   _selectedDistrictValue = result[1];
        //   _selectedSubDistrictValue = result[2];
        //   setState(() {});
        // }
        break;
    }
    // print("isdone1: $isDone va isDOne2: $isDone2");
    return AppBarContainer(
      titleString: LocalizationText.hotelManager,
      implementTrailing: true,
      child: Center(
        child: body,
      ),
      drawer: DrawerPage(
        callback: callback,
        setPage: (index) {
          setState(() {
            section = index;
            isFirst = false;
          });
        },
        buttonNames: [
          ButtonsInfo(title: LocalizationText.home, icon: Icons.home),
          // ButtonsInfo(title: LocalizationText.amenitiesAdd, icon: Icons.add),
          // ButtonsInfo(
          //     title: LocalizationText.amenitiesDelete, icon: Icons.delete),
          ButtonsInfo(title: LocalizationText.profile, icon: Icons.face),
          ExpansionTile(
            title: Text(LocalizationText.amenitiesList),
            children: <Widget>[
              // Text(LocalizationText.amenitiesAdd),
              Row(
                children: [
                  Text(LocalizationText.amenitiesAdd),
                  Icon(
                      // <-- Icon
                      Icons.add,
                      size: 24.0,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  Text(LocalizationText.amenitiesDelete),
                  Icon(
                      // <-- Icon
                      Icons.delete,
                      size: 24.0,
                      color: Colors.white),
                ],
              ),
              // Text(LocalizationText.amenitiesDelete)
            ],
          ),

          ExpansionTile(
            title: Text(LocalizationText.hotels),
            children: <Widget>[
              Row(
                children: [
                  Text(LocalizationText.updateMyhotel),
                  Icon(
                      // <-- Icon
                      Icons.update_rounded,
                      size: 24.0,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  Text(LocalizationText.createMyHotel),
                  Icon(
                      // <-- Icon
                      Icons.create_rounded,
                      size: 24.0,
                      color: Colors.white),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
