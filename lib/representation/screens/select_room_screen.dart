import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/checkout_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/hotel_card_widget.dart';
import 'package:travel_app_ytb/representation/widgets/room_card_widget.dart';

import '../../core/constants/dismention_constants.dart';

class SelectRoomScreen extends StatefulWidget {
  const SelectRoomScreen({super.key});

  static const String routeName = '/select_room_screen';

  @override
  State<SelectRoomScreen> createState() => _SelectRoomScreenState();
}

class _SelectRoomScreenState extends State<SelectRoomScreen> {
  static final Map<int, Map<String, dynamic>> listRooms = {
    0: {
      'imageFilePath': AssetHelper.roomImage1,
      'name': 'Deluxe Room',
      'roomSize': 27,
      'services': const <String>[
        'Free Wifi',
        'Non Refundable',
        'Free Breakfast',
        'Non Smoking'
      ],
      'priceInfo': 245,
    },
    1: {
      'imageFilePath': AssetHelper.roomImage2,
      'name': 'Executive Suite',
      'roomSize': 32,
      'services': const <String>[
        'Free Wifi',
        'Non Refundable',
        'Free Breakfast',
        'Non Smoking'
      ],
      'priceInfo': 289,
    },
    2: {
      'imageFilePath': AssetHelper.roomImage3,
      'name': 'King Bed Only Room',
      'roomSize': 24,
      'services': const <String>[
        'Free Wifi',
        'Non Refundable',
        'Free Breakfast',
        'Non Smoking'
      ],
      'priceInfo': 214,
    }
  };

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: LocalizationText.selectRoom,
      implementLeading: true,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(listRooms.length, (index) {
            return Column(
              children: [
                RoomCardWidget(
                  widthContainer: MediaQuery.of(context).size.width * 0.9,
                  imageFilePath: listRooms[index]!['imageFilePath'],
                  name: listRooms[index]!['name'],
                  roomSize: listRooms[index]!['roomSize'],
                  services: listRooms[index]!['services'],
                  priceInfo: listRooms[index]!['priceInfo'],
                  ontap: () {
                    Navigator.pushNamed(
                      context,
                      CheckoutScreen.routeName,
                      arguments: listRooms[index],
                    );
                  },
                ),
                const SizedBox(
                  height: kDefaultPadding * 2,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
