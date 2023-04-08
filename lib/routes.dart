import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/screens/checkout_screen.dart';
import 'package:travel_app_ytb/representation/screens/flight_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/forgot_password_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail_screen.dart';
import 'package:travel_app_ytb/representation/screens/intro_screen.dart';
import 'package:travel_app_ytb/representation/screens/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';
import 'package:travel_app_ytb/representation/screens/result_flight_screen.dart';
import 'package:travel_app_ytb/representation/screens/search_hotels_screen.dart';
import 'package:travel_app_ytb/representation/screens/select_date_screen.dart';
import 'package:travel_app_ytb/representation/screens/select_guest_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/select_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/sign_up_screen.dart';
import 'package:travel_app_ytb/representation/screens/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  HotelBookingScreen.routeName: (context) => const HotelBookingScreen(),
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
  SelectGuestRoomScreen.routeName: (context) => const SelectGuestRoomScreen(),
  SearchHotelsScreen.routeName: (context) => const SearchHotelsScreen(),
  HotelDetailScreen.routeName: (context) => const HotelDetailScreen(),
  SelectRoomScreen.routeName: (context) => const SelectRoomScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  FlightBookingScreen.routeName: (context) => const FlightBookingScreen(),
  ResultFlightScreen.routeName: (context) => const ResultFlightScreen(),
};
