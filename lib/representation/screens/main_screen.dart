import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/favorite_screen.dart';
import 'package:travel_app_ytb/representation/screens/home/home_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/widgets/animation/alarm_animation.dart';
import 'hotel_booking/hotel_booking_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.currentIndex = 0});
  final int currentIndex;

  static String routeName = 'main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Widget? home;
  Widget? favorite;
  Widget? hotel;
  Widget? profile;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    // home = HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          home ?? HomeScreen(),
          favorite ?? Container(),
          hotel ?? Container(),
          profile ?? ProfilePage(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex != index) {
            if (index == 0) {
              home = new HomeScreen();
            }
            else if (index == 1) {
              favorite = new FavoriteScreen();
            } else if (index == 2 && hotel == null) {
              hotel = HotelBookingScreen(
                useImplementLeading: false,
              );
            } else if (index == 3 && profile == null) {
              profile = ProfilePage();
            }
            setState(() {
              _currentIndex = index;
            });
          }
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
            // TODO remove fake data
            activeIcon: const AlarmAnimation(),
            title: Text(LocalizationText.user),
          ),
        ],
      ),
    );
  }
}
