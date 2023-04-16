// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/controllers/home_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/booking_flights_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail_screen.dart';
import 'package:travel_app_ytb/representation/screens/result_flight_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/custom_checkbox_icon.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/constants/textstyle_constants.dart';
import '../../widgets/item_text_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController? _controller;
  String? userName;
  String? photoUrl;
  int _selectedCard = -1;
  List<String> images = [
    "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
    "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
  ];
  List<_DestinationEntity> listItem = [
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),_DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    ),
    _DestinationEntity(
        url: "https://images.unsplash.com/photo-1468877294001-94aef5ebfa1e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8bW91dGFpbnxlbnwwfHwwfHw%3D&w=1000&q=80",
        address: "adressss",
        isSelected: false
    )
  ];

  @override
  void initState() {
    super.initState();
    _controller = HomeScreenController();
  }

  @override
  Widget build(BuildContext context) {
    double ratio = 0.5;
    setState(() {
      userName = _controller?.getUser()?.name;
      photoUrl = _controller?.getUser()?.photoUrl;
    });
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
      child: SingleChildScrollView(
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
                      ontap: () => {
                        Navigator.of(context)
                            .pushNamed(BookingFlightsScreen.routeName)
                      },
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
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    "Popular Destinations",
                    style: TextStyles.defaultStyle.blackTextColor
                    .setTextSize(18).bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TapableWidget(
                    onTap: () {
                      print("next screen");
                    },
                    child: Text(
                      "See All",
                      style: TextStyles.defaultStyle.blackTextColor
                          .setTextSize(16).bold.setColor(Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 8,
                  children: [
                    for (var i = 0; i < listItem.length; i++) StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: i.isEven ? 2 : 1,
                        child: CardDestinations(
                          url: listItem[i].url,
                          address: listItem[i].address,
                          isSelected: listItem[i].isSelected,
                        )
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}

class _DestinationEntity {
    final String? url;
    final String? address;
    bool isSelected;
    _DestinationEntity({this.url, this.address, required this.isSelected});
}

class CardDestinations extends StatelessWidget {
  CardDestinations({Key? key, this.url, this.address, this.isSelected = false}) : super(key: key);
  final String? url;
  final String? address;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TapableWidget(
      onTap: () {
          print("next screen destinations");
      },
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                url ?? "",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
              left: 10,
              bottom: 50,
              child: Text(
                address ?? "",
                style: TextStyles.defaultStyle.bold.whiteTextColor,
              )
          ),
          Positioned(
              top: 10,
              right: 10,
              height: kDefaultIconSize,
              width: kDefaultIconSize,
              child: CustomCheckboxIcon(
                onChanged: (bool? value) {
                  isSelected = value!;
                  print(isSelected);
                },
                isChecked: isSelected,
                selected: ImageHelper.loadFromAsset(AssetHelper.heartRedIcon),
                unselected: ImageHelper.loadFromAsset(AssetHelper.heartWhileIcon),
              )
          ),
          Positioned(
              bottom: 5,
              left: 10,
              width: 60,
              height: 30,
              child: Container(
                padding: EdgeInsets.all(kMinPadding),
                decoration: BoxDecoration(
                  color: ColorPalette.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: ImageHelper.loadFromAsset(AssetHelper.starYellowIcon)
                    ),
                    Expanded(
                        flex: 1,
                        child: Text(
                            "4.5",
                          textAlign: TextAlign.end,
                        )
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
