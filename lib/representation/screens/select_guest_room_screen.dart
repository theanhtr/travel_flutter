import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/add_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class SelectGuestRoomScreen extends StatefulWidget {
  const SelectGuestRoomScreen({super.key});

  static String routeName = '/select_guest_room_screen';

  @override
  State<SelectGuestRoomScreen> createState() => _SelectGuestRoomScreenState();
}

class _SelectGuestRoomScreenState extends State<SelectGuestRoomScreen> {
  int guestCount = 1;
  int roomCount = 1;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> argss =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    guestCount = argss['guestCount'];
    roomCount = argss['roomCount'];

    return AppBarContainer(
      titleString: 'Add guest and room',
      implementLeading: true,
      child: Column(
        children: [
          const SizedBox(
            height: kMediumPadding * 2,
          ),
          StatefulBuilder(builder: (context, setState) {
            return AddTabContainer(
              icon: FontAwesomeIcons.peopleGroup,
              content: 'Guest',
              sizeItem: kDefaultIconSize,
              sizeText: kDefaultTextSize,
              primaryColor: const Color(0xffFE9C5E),
              secondaryColor: const Color(0xffFE9C5E).withOpacity(0.2),
              count: guestCount,
              onCountChanged: (int newCount) {
                guestCount = newCount;
                setState(() {});
              },
            );
          }),
          const SizedBox(
            height: kDefaultPadding,
          ),
          StatefulBuilder(builder: (context, setState) {
            return AddTabContainer(
              icon: FontAwesomeIcons.peopleRoof,
              content: 'Room',
              sizeItem: kDefaultIconSize,
              sizeText: kDefaultTextSize,
              primaryColor: const Color(0xffF77777),
              secondaryColor: const Color(0xffF77777).withOpacity(0.2),
              count: roomCount,
              onCountChanged: (int newCount) {
                roomCount = newCount;
                setState(() {});
              },
            );
          }),
          const SizedBox(
            height: kDefaultPadding,
          ),
          ButtonWidget(
            title: 'Done',
            ontap: () {
              Navigator.of(context).pop([guestCount, roomCount]);
            },
          ),
        ],
      ),
    );
  }
}
