// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/controllers/home_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../core/constants/textstyle_constants.dart';
import '../widgets/item_text_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController? _controller;
  String? userName;
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _controller = HomeScreenController();
    setState(() {
      userName = _controller?.getUser()?.displayName;
      photoUrl = _controller?.getUser()?.photoURL;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      title: Container(
        margin: const EdgeInsets.only(top: kItemPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: kItemPadding,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $userName',
                    style: TextStyles.defaultStyle.whiteTextColor.bold
                        .setTextSize(24),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding),
                    child: Text(
                      'Where are you going next?',
                      style: TextStyles.defaultStyle.whiteTextColor
                          .setTextSize(12),
                    ),
                  )
                ],
              ),
            ),
            const Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: kDefaultIconSize * 1.2,
            ),
            Container(
              margin: const EdgeInsets.only(left: kDefaultPadding),
              child: photoUrl != null ? ClipRRect(
                borderRadius: BorderRadius.circular(kMinPadding),
                child: Image.network(
                  photoUrl!,
                  width: kDefaultIconSize * 2.5,
                  fit: BoxFit.cover,
                ),
              ) : ImageHelper.loadFromAsset(
                AssetHelper.userAvatar,
                width: kDefaultIconSize * 2.5,
                radius: BorderRadius.circular(kMinPadding),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextField(
            decoration: InputDecoration(
                hintText: 'Search your destination',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kTopPadding),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: kDefaultIconSize,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      BorderRadius.all(Radius.circular(kDefaultPadding)),
                )),
          ),
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            child: SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemText(
                    icon: FontAwesomeIcons.hotel,
                    text: 'Hotels',
                    sizeItem: kDefaultPadding * 2,
                    sizeText: 16,
                    primaryColor: Color(0xffFE9C5E),
                    secondaryColor: Color(0xffFE9C5E).withOpacity(0.2),
                    ontap: () => {
                      Navigator.of(context)
                          .pushNamed(HotelBookingScreen.routeName)
                    },
                  ),
                  ItemText(
                    icon: FontAwesomeIcons.plane,
                    text: 'Flights',
                    sizeItem: kDefaultPadding * 2,
                    sizeText: 16,
                    primaryColor: Color(0xffF77777),
                    secondaryColor: Color(0xffF77777).withOpacity(0.2),
                  ),
                  ItemText(
                    icon: FontAwesomeIcons.earthAsia,
                    text: 'All',
                    sizeItem: kDefaultPadding * 2,
                    sizeText: 16,
                    primaryColor: Color(0xff3EC8BC),
                    secondaryColor: Color(0xff3EC8BC).withOpacity(0.2),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
