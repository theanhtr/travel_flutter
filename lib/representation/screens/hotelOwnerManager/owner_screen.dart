import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/hotelOwnerManager/hotel_owner_manager.dart';

import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/admin/add_user_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/drawer_page_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/hotel_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/panelCenter_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/amenity_manager.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/home_owner_page.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/type_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/sign_up_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../room_booking/select_room_screen.dart';
import 'add_type_room_screen.dart';

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
  // hotelManager hotelManager;
  // @override
  // void initState() {
  //   super.initState();
  //   hotelManager = hotelManager();
  // }

  @override
  Widget build(BuildContext context) {
    Function callback = () {
      setState(() {});
    };
    // print("isFirst dong 36 $isFirst");
    if (isFirst) {
      isFirst = false;
      widget.hotelManager.getAllTypeRoom().then((value) => {
            // print("value1 day $value"),
            widget.hotelManager.viewAllAmenities().then((value) => {
                  // print("value2 day $value"),
                  isDone = 1,
                  isDone2 = 1,
                }),
          });
      setState(() {});
    }
    if (isDone == 1 && isDone2 == 1) {
      print("amenity list");
      debugPrint(widget.hotelManager.getListAmenities.toString());
      debugPrint(widget.hotelManager.getTypeRoomList.toString());
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

      // case 2:
      //   if (isDone2-- > 0) {
      //     // print("user hotel ${widget.hotelManager.getUserList}");
      //     isFirst = false;
      //     body = ManageUser(usersList: widget.hotelManager.getTypeRoomList);
      //     isDone2 = 1;
      //   } else {
      //     isFirst = false;
      //     body = Loading();
      //   }
      //   break;
      case 2:
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
      case 3:
        if (isDone-- > 0) {
          isFirst = false;
          body = TypeRoomScreen();
          isDone = 1;
        } else {
          isFirst = false;
          body = Loading();
        }
        break;
      case 4:
        if (isDone-- > 0) {
          isFirst = false;
          body = AddTypeRoomScreen();
          isDone = 1;
        } else {
          isFirst = false;
          body = Loading();
        }
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
        setPage: (index) {
          setState(() {
            section = index;
            isFirst = false;
          });
        },
        buttonNames: [
          ButtonsInfo(title: LocalizationText.home, icon: Icons.home),
          ButtonsInfo(title: LocalizationText.amenitiesAdd, icon: Icons.add),
          ButtonsInfo(
              title: LocalizationText.amenitiesDelete, icon: Icons.delete),
          ButtonsInfo(
              title: LocalizationText.seeRoomType, icon: Icons.view_array),
          ButtonsInfo(
              title: LocalizationText.addTypeRoom, icon: Icons.add),
          // ButtonsInfo(title: "Notifications", icon: Icons.notifications),
          // ButtonsInfo(title: "Contacts", icon: Icons.contact_phone_rounded),
          // ButtonsInfo(title: "Sales", icon: Icons.sell),
          // ButtonsInfo(title: "Marketing", icon: Icons.mark_email_read),
          // ButtonsInfo(title: "Security", icon: Icons.verified_user),
          // ButtonsInfo(
          //     title: LocalizationText.hotelManager,
          //     icon: Icons.supervised_user_circle_rounded),
          // ButtonsInfo(
          //     title: LocalizationText.userManagement,
          //     icon: Icons.verified_user),
          // ButtonsInfo(title: LocalizationText.profile, icon: Icons.face),
          // ButtonsInfo(
          //     title: LocalizationText.addUser, icon: Icons.plus_one_rounded),
        ],
      ),
    );
  }
}
