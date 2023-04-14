import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/screens/facility_flight_screen.dart';
import 'package:travel_app_ytb/representation/screens/facility_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/google_map_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_filter_screen.dart';
import 'package:travel_app_ytb/representation/screens/property_type_screen.dart';
import 'package:travel_app_ytb/representation/screens/sort_by_filght_screen.dart';
import 'package:travel_app_ytb/representation/screens/sort_by_hotel_screen.dart';

import 'package:travel_app_ytb/representation/screens/splash_screen.dart';
import 'package:travel_app_ytb/representation/widgets/slider.dart';
import 'package:travel_app_ytb/routes.dart';
import './core/constants/color_palatte.dart';

void main() async {
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale("en"), Locale("vi")],
        path: 'assets/translations',
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
        theme: ThemeData(
          primaryColor: ColorPalette.primaryColor,
          scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
          backgroundColor: ColorPalette.backgroundScaffoldColor,
        ),
        routes: routes,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        );
  }
}
