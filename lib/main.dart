import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/screens/facility_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/splash_screen.dart';
import 'package:travel_app_ytb/routes.dart';
import './core/constants/color_palatte.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorPalette.primaryColor,
        scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
        backgroundColor: ColorPalette.backgroundScaffoldColor,
      ),
      routes: routes,
      debugShowCheckedModeBanner: false,
      home: const FacilityHotel(),
      // home: const HotelBookingScreen()
      //  home: const SplashScreen(),
    );
  }
}
