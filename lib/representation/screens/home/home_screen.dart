// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/controllers/home_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/booking_flights_screen.dart';
import 'package:travel_app_ytb/representation/screens/see_all_destinations_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/custom_checkbox_icon.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';

import '../../../core/constants/textstyle_constants.dart';
import '../../widgets/item_text_container.dart';
import '../hotel_booking/hotel_booking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenController? _controller;
  String? userName;
  String? photoUrl;
  List<_DestinationEntity> listItem = [];
  bool _isLoaded = false;
  bool isFirst = true;

  @override
  void initState() {
    super.initState();
    _controller = HomeScreenController();
  }

  @override
  Widget build(BuildContext context) {
    double ratio = 0.5;
    if (isFirst) {
      isFirst = false;
      setState(() {
        userName = _controller?.getUser()?.name;
        photoUrl = _controller?.getUser()?.photoUrl;
      });
    }
    if (_isLoaded == false) {
      _isLoaded = true;
      _controller?.getPopularDestination().then((destinations) => {
            setState(() {
              if (destinations != false) {
                destinations.forEach((element) {
                  listItem.add(
                    _DestinationEntity(
                      isSelected: element['is_like'],
                      provinceId: element['province_id'],
                      provinceName: element['province_name'],
                      imagePath: element['image_path'],
                      id: element['id'],
                    ),
                  );
                });
              }
            }),
          });
    }
    debugPrint('${listItem.length}');
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
              child: photoUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      child: Image.network(
                        photoUrl!,
                        width: kDefaultIconSize * 2.5,
                        height: kDefaultIconSize * 2.5,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: const SpinKitCircle(
                              color: Colors.black,
                              size: 20.0,
                            ),
                          );
                        },
                      ),
                    )
                  : ImageHelper.loadFromAsset(
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
                        .setTextSize(18)
                        .bold,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TapableWidget(
                    onTap: () async {
                      await Navigator.pushNamed(
                          context, SeeAllDestinationsScreen.routeName);
                      listItem = [];
                      _isLoaded = false;
                      setState(() {});
                    },
                    child: Text(
                      "See All",
                      style: TextStyles.defaultStyle.blackTextColor
                          .setTextSize(16)
                          .bold
                          .setColor(Colors.blueAccent),
                    ),
                  ),
                ),
              ],
            ),
            listItem.isNotEmpty
                ? Container(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 8,
                      children: [
                        for (var i = 0; i < listItem.length; i++)
                          StaggeredGridTile.count(
                              crossAxisCellCount: 1,
                              mainAxisCellCount: i.isEven ? 2 : 1,
                              child: CardDestinations(
                                imagePath: listItem[i].imagePath,
                                provinceName: listItem[i].provinceName,
                                isSelected:
                                    listItem[i].isSelected == 1 ? true : false,
                                onTap: () {
                                  print("next screeen");
                                },
                                onChangeSelected: () {
                                  _controller
                                      ?.likePopularDestination(
                                          listItem[i].id ?? 0)
                                      .then((value) =>
                                          {debugPrint(value.toString())});
                                },
                              ))
                      ],
                    ))
                : SpinKitCircle(
                    color: Colors.black,
                    size: 64.0,
                  )
          ],
        ),
      ),
    );
  }
}

class _DestinationEntity {
  final int? id;
  final int? provinceId;
  final String? imagePath;
  final String? provinceName;
  int isSelected;

  _DestinationEntity(
      {this.id,
      this.provinceId,
      this.imagePath,
      this.provinceName,
      required this.isSelected});
}

class CardDestinations extends StatelessWidget {
  CardDestinations({
    Key? key,
    this.imagePath,
    this.provinceName,
    this.isSelected = false,
    this.onTap,
    required this.onChangeSelected,
  }) : super(key: key);
  final String? imagePath;
  final String? provinceName;
  final Function()? onTap;
  final Function() onChangeSelected;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return TapableWidget(
      onTap: onTap,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imagePath ?? "",
                fit: BoxFit.fitHeight,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const SpinKitCircle(
                    color: Colors.black,
                    size: 64.0,
                  );
                },
              ),
            ),
          ),
          Positioned(
              left: 10,
              bottom: 50,
              child: Text(
                provinceName ?? "",
                style: TextStyles.defaultStyle.bold.whiteTextColor,
              )),
          Positioned(
              top: 10,
              right: 10,
              height: kDefaultIconSize,
              width: kDefaultIconSize,
              child: CustomCheckboxIcon(
                onChanged: (bool? value) {
                  onChangeSelected();
                  isSelected = value!;
                },
                isChecked: isSelected,
                selected: ImageHelper.loadFromAsset(AssetHelper.heartRedIcon),
                unselected:
                    ImageHelper.loadFromAsset(AssetHelper.heartWhileIcon),
              )),
          Positioned(
              bottom: 5,
              left: 10,
              width: 60,
              height: 30,
              child: Container(
                padding: EdgeInsets.all(kMinPadding),
                decoration: BoxDecoration(
                    color: ColorPalette.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: ImageHelper.loadFromAsset(
                            AssetHelper.starYellowIcon)),
                    Expanded(
                        flex: 1,
                        child: Text(
                          "4.5",
                          textAlign: TextAlign.end,
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
