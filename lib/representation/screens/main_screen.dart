import 'dart:async';
import 'dart:convert';

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
import '../../helpers/http/base_client.dart';
import '../../helpers/loginManager/login_manager.dart';
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
  bool _isNeedReview = false;
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

  Future<bool> checkNeedReview() async {
    var response = await BaseClient(LoginManager().userModel.token ?? "")
        .get('/orders/check-need-review')
        .catchError((onError) {
      return onError;
    });
    debugPrint("64 alskdfj $response");
    if (response == null) {
      return false;
    }
    if (response.runtimeType == int) {
      return false;
    }
    Map dataResponse = await json.decode(response);
    return dataResponse['data'];
  }

  @override
  Widget build(BuildContext context) {
    // checkNeedReview().then((value) => {
    //   _isNeedReview = value,
    //   setState((){}),
    // });
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
            } else if (index == 1) {
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
            activeIcon: _isNeedReview == true ? const AlarmAnimation() : null,
            title: Text(LocalizationText.user),
          ),
        ],
      ),
    );
  }
}
