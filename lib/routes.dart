import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/screens/admin_screen.dart';
import 'package:travel_app_ytb/representation/screens/booking_flights_screen.dart';
import 'package:travel_app_ytb/representation/screens/checkout/checkout_screen.dart';
import 'package:travel_app_ytb/representation/screens/checkout/contact_details_screen.dart';
import 'package:travel_app_ytb/representation/screens/edit_profile_page.dart';
import 'package:travel_app_ytb/representation/screens/facility_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/favorite_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/flight_filter_screen.dart';
import 'package:travel_app_ytb/representation/screens/forgot_password/forgot_password_screen.dart';
import 'package:travel_app_ytb/representation/screens/forgot_password/reset_password_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/add_rooms_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/add_type_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/change_image_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/owner_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/update_type_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/create_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/owner_screen.dart';
import 'package:travel_app_ytb/representation/screens/home/result_search_text_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/home/search_in_home_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/search_hotels_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/search_your_destination_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_date_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_guest_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail/hotel_detail_screen.dart';
import 'package:travel_app_ytb/representation/screens/intro_screen.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';
import 'package:travel_app_ytb/representation/screens/order/HotelDetailFromOrderHistoryScreen.dart';
import 'package:travel_app_ytb/representation/screens/order/order_history_screen.dart';
import 'package:travel_app_ytb/representation/screens/order/re_order_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/result_flight_screen.dart';
import 'package:travel_app_ytb/representation/screens/room_booking/select_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/see_all_destinations_screen.dart';
import 'package:travel_app_ytb/representation/screens/sign_up_screen.dart';
import 'package:travel_app_ytb/representation/screens/sort_by_filght_screen.dart';
import 'package:travel_app_ytb/representation/screens/sort_by_hotel_screen.dart';
import 'package:travel_app_ytb/representation/screens/splash_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_fill_in_information_screen.dart';

import 'representation/screens/hotelOwnerManager/type_room_screen.dart';
import 'representation/screens/hotelOwnerManager/update_hotel_screen.dart';
import 'representation/screens/property_type_screen.dart';
import 'representation/screens/reviews/reviews_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  IntroScreen.routeName: (context) => const IntroScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  HotelBookingScreen.routeName: (context) => const HotelBookingScreen(),
  FavoriteBookingScreen.routeName: (context) => const FavoriteBookingScreen(),
  SelectDateScreen.routeName: (context) => SelectDateScreen(),
  SelectGuestRoomScreen.routeName: (context) => const SelectGuestRoomScreen(),
  SearchHotelsScreen.routeName: (context) => const SearchHotelsScreen(),
  HotelDetailScreen.routeName: (context) => const HotelDetailScreen(),
  SelectRoomScreen.routeName: (context) => const SelectRoomScreen(),
  CheckoutScreen.routeName: (context) => const CheckoutScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  BookingFlightsScreen.routeName: (context) => const BookingFlightsScreen(),
  ResultFlightScreen.routeName: (context) => const ResultFlightScreen(),
  FacilityHotel.routeName: (context) => const FacilityHotel(),
  PropertyType.routeName: (context) => const PropertyType(),

  SortByHotel.routeName: (context) => const SortByHotel(),
  SortByFlight.routeName: (context) => const SortByFlight(),
  FlightFilterScreen.routeName: (context) => const FlightFilterScreen(),
  ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  SearchYourDestinationScreen.routeName: (context) =>
      const SearchYourDestinationScreen(),

  // HotelFilterScreen.routeName: (context) => const HotelFilterScreen(),
  //ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
  ProfilePage.routeName: (context) => ProfilePage(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
  FillInforScreen.routeName: (context) => const FillInforScreen(),
  // UploadIamge.routename: (context) => UploadIamge(),
  AdminScreen.routeName: (context) => AdminScreen(),
  SeeAllDestinationsScreen.routeName: (context) =>
      const SeeAllDestinationsScreen(),
  ContactDetailsScreen.routeName: (context) => const ContactDetailsScreen(),
  // FillInforScreen.routeName: (context) => const FillInforScreen()
  ReviewsScreen.routeName: (context) => const ReviewsScreen(),
  HotelOwnerScreen.routeName: (context) => HotelOwnerScreen(),
  TypeRoomScreen.routeName: (context) => TypeRoomScreen(),
  AddTypeRoomScreen.routeName: (context) => AddTypeRoomScreen(),
  UpdateTypeRoomScreen.routeName: (context) => UpdateTypeRoomScreen(),
  AddRoomsScreen.routeName: (context) => AddRoomsScreen(),
  ChangeImageScreen.routeName: (context) => ChangeImageScreen(),
  HotelOwnerScreen.routeName: (context) => HotelOwnerScreen(),
  CreateHotelScreen.routeName: (context) => CreateHotelScreen(),
  UpdateHotelScreen.routeName: (context) => UpdateHotelScreen(),
  SearchInHomeScreen.routeName: (context) => const SearchInHomeScreen(),
  ResultSearchTextHotelScreen.routeName: (context) =>
      const ResultSearchTextHotelScreen(),
  OrderHistoryScreen.routeName: (context) => const OrderHistoryScreen(),
  HotelDetailFromOrderHistoryScreen.routeName: (context) =>
      const HotelDetailFromOrderHistoryScreen(),
  ReOrderScreen.routeName: (context) => const ReOrderScreen(),
};
