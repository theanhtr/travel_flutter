import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/login_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_fill_in_information_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/line_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../../widgets/booking_hotel_tab_container.dart';
import '../facility_hotel_screen.dart';
import 'add_type_room_controller.dart';

/*
...
...Đã làm chuyển ngữ
*/
class AddTypeRoomScreen extends StatefulWidget {
  const AddTypeRoomScreen({super.key});

  static const String routeName = '/add_type_room_screen';

  @override
  State<AddTypeRoomScreen> createState() => _AddTypeRoomScreenState();
}

class _AddTypeRoomScreenState extends State<AddTypeRoomScreen> {
  String roomName = "";
  String description = "";
  String price = "";
  String occupancy = "";
  String numberOfBeds = "";
  String roomSize = "";
  String amenities = "";
  List<int> amenitiesResults = [];
  AddTypeRoomController? _controller;

  @override
  Widget build(BuildContext context) {
    _controller = AddTypeRoomController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.roomName,
              onchange: (String value) {
                roomName = value;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.description,
              onchange: (String value) {
                description = value;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.price,
              onchange: (String value) {
                price = value;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.occupancy,
              onchange: (String value) {
                occupancy = value;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.numberOfBeds,
              onchange: (String value) {
                numberOfBeds = value;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          StatefulBuilder(
            builder: (context, setState) => InputCard(
              style: TypeInputCard.roomSize,
              onchange: (String value) {
                roomSize = value;
              },
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          BookingHotelTab(
            icon: FontAwesomeIcons.suitcaseMedical,
            title: LocalizationText.facilities,
            description: '',
            sizeItem: kDefaultIconSize / 1.5,
            sizeText: kDefaultIconSize / 1.2,
            primaryColor: const Color(0xffFE9C5E),
            secondaryColor: const Color(0xffFE9C5E).withOpacity(0.2),
            iconString: AssetHelper.wifiIcon,
            useIconString: '',
            bordered: '',
            ontap: () async {
              await Navigator.pushNamed(context, FacilityHotel.routeName,
                  arguments: {
                    'oldAmenities': amenitiesResults,
                    'getData': (listCheckboxPosition, amenitiesT) {
                      amenities = amenitiesT;
                      amenitiesResults = listCheckboxPosition;
                    },
                  });
            },
          ),
          const SizedBox(
            height: kDefaultPadding * 2,
          ),
          ButtonWidget(
            title: LocalizationText.addTypeRoom,
            ontap: () {
              Loading.show(context);
              _controller
                  ?.addTypeRoom(roomName, description, price, occupancy,
                      numberOfBeds, roomSize, amenities)
                  .then((value) => {
                        Loading.dismiss(context),
                        if (value == true)
                          {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              title: LocalizationText.success,
                              btnOkOnPress: () {},
                            ).show()
                          }
                        else
                          {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              title: LocalizationText.err,
                              btnOkOnPress: () {},
                            ).show(),
                          },
                      });
            },
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
