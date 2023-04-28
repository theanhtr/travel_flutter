import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_google_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/favorite_screen.dart';
import 'package:travel_app_ytb/representation/screens/home/home_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_fill_in_information_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static String routeName = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          FavoriteScreen(),
          HotelBookingScreen(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.opacityColor,
        margin: const EdgeInsets.symmetric(
            vertical: kMediumPadding, horizontal: kMediumPadding),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.house,
              size: kDefaultIconSize,
            ),
            title: Text(LocalizationText.home),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.solidHeart,
              size: kDefaultIconSize,
            ),
            title: Text(LocalizationText.favourite),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.briefcase,
              size: kDefaultIconSize,
            ),
            title: Text(LocalizationText.booking),
          ),
          SalomonBottomBarItem(
            icon: const Icon(
              FontAwesomeIcons.solidUser,
              size: kDefaultIconSize,
            ),
            title: Text(LocalizationText.user),
          ),
        ],
      ),
    );
  }
}
