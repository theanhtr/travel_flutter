import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/adminManager/admin_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/admin/add_user_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/drawer_page_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/hotel_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/panelCenter_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

class AdminScreen extends StatefulWidget {
  AdminScreen({super.key});
  static const String routeName = '/admin_screen';
  var adminManager = AdminManager();
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

enum Section { HOME, ALL_HOTELS, ALL_USER }

class _AdminScreenState extends State<AdminScreen> {
  int section = 0;
  bool isFirst = true;
  bool _isLoading = false;
  bool _canLoadCardView = false;
  int isDone = 0;
  int isDone2 = 0;
  // AdminManager adminManager;
  //   @override
  // void initState() {
  //   super.initState();
  //   adminManager = AdminManager();
  // }
  @override
  Widget build(BuildContext context) {
    // print("isFirst dong 36 $isFirst");
    if (isFirst) {
      isFirst = false;
      widget.adminManager.getAllUser().then((value) => {
            // print("value1 day $value"),
            widget.adminManager.viewAllHotel().then((value) => {
                  // print("value2 day $value"),
                  isDone = 1,
                  isDone2 = 1,
                }),
          });
      // setState(() {});
    }
    if (isDone == 1 && isDone2 == 1) {
      // isFirst = true;
      _isLoading = false;
      _canLoadCardView = false;
    }
    // widget.adminManager.viewAllHotel();
    debugPrint('${section}');
    Widget body = Scaffold(
      body: Text(LocalizationText.home),
    );

    switch (section) {
      /// Display the home section, simply by
      case 0:
        body = HomeAdminPage();
        break;

      case 1:
        if (isDone-- > 0) {
          // print("admin hotel ${widget.adminManager.getListHotel}");
          isFirst = false;
          body = AdminManageHotel(
            hotelsList: widget.adminManager.getListHotel,
          );
          isDone = 1;
        } else {
          isFirst = false;
          body = Loading();
        }

        break;

      case 2:
        if (isDone2-- > 0) {
          // print("user hotel ${widget.adminManager.getUserList}");
          isFirst = false;
          body = ManageUser(usersList: widget.adminManager.getUserList);
          isDone2 = 1;
        } else {
          isFirst = false;
          body = Loading();
        }
        break;
      case 3:
        body = ProfilePage();
        break;
      case 4:
        body = AddUserScreen();
        break;
    }
    // print("isdone1: $isDone va isDOne2: $isDone2");
    return AppBarContainer(
      titleString: LocalizationText.admin,
      implementTrailing: true,
      child: Center(
        child: body,
      ),
      drawer: DrawerPage(
        callback: () {},
        setPage: (index) {
          setState(() {
            section = index;
            isFirst = false;
          });
        },
        buttonNames: [
          ButtonsInfo(title: LocalizationText.home, icon: Icons.home),
          // ButtonsInfo(title: "Setting", icon: Icons.settings),
          // ButtonsInfo(title: "Notifications", icon: Icons.notifications),
          // ButtonsInfo(title: "Contacts", icon: Icons.contact_phone_rounded),
          // ButtonsInfo(title: "Sales", icon: Icons.sell),
          // ButtonsInfo(title: "Marketing", icon: Icons.mark_email_read),
          // ButtonsInfo(title: "Security", icon: Icons.verified_user),
          ButtonsInfo(
              title: LocalizationText.hotelManager,
              icon: Icons.supervised_user_circle_rounded),
          ButtonsInfo(
              title: LocalizationText.userManagement,
              icon: Icons.verified_user),
          ButtonsInfo(title: LocalizationText.profile, icon: Icons.face),
          ButtonsInfo(
              title: LocalizationText.addUser, icon: Icons.plus_one_rounded),
        ],
      ),
    );
  }
}
