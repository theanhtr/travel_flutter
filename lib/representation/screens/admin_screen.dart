import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/representation/screens/admin/drawer_page_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/delete_user_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/hotel_management_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/panelCenter_screen.dart';
import 'package:travel_app_ytb/representation/screens/admin/user_screen.dart';

import 'package:travel_app_ytb/representation/screens/test_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  static const String routeName = '/admin_screen';
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

enum Section { HOME, ALL_HOTELS, ALL_USER }

class _AdminScreenState extends State<AdminScreen> {
  int section = 0;
  @override
  Widget build(BuildContext context) {
    debugPrint('${section}');
    Widget body = Scaffold(
      body: Text("body of admin"),
    );

    switch (section) {
      /// Display the home section, simply by
      case 0:
        body = HomeAdminPage();
        break;

      case 1:
        body = AdminManageHotel();
        break;

      case 2:
        body = AdminManageUser();
        break;
    }
    return AppBarContainer(
      titleString: 'Admin',
      implementTrailing: true,
      child: Center(
        child: body,
      ),
      drawer: DrawerPage(
        setPage: (index) {
          setState(() {
            section = index;
          });
        },
      ),
    );
  }
}




// Scaffold(
//       backgroundColor: ColorPalette.purpleDark,
//       appBar: AppBar(
//         title: Text("im admin"),
//       ),
//       body: Center(
//         child: body,
//       ),
//       drawer: DrawerPage(
//         setPage: (index) {
//           setState(() {
//             section = index;
//           });
//         },
//       ),
//     );
