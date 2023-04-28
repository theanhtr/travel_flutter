import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/service_load_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/select_room_screen.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';

import '../../controllers/hotel_detail_screen_controller.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  static const String routeName = "/hotel_detail_screen";

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  String? name;
  String? priceInfo;
  String? locationInfo;
  String? distanceInfo;
  double? starInfo;
  int? countReviews;
  int id = -1;
  String? description;
  String? locationSpecial;
  List<String>? services;
  bool isLike = false;
  bool isFirst = true;

  final PageController _pageController = PageController();
  int pageCount = 3;

  final StreamController<double> _pageStreamController =
      StreamController<double>.broadcast();

  @override
  void initState() {
    super.initState();

    pageCount = 3;
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toDouble());
    }); //hàm chạy vào mỗi khi có sự kiện
  }

  Widget _buildItemHotelDetail(String image) {
    return Stack(
      children: [
        Positioned.fill(
            child: ImageHelper.loadFromAsset(
          image,
          fit: BoxFit.fill,
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    name = args['name'];
    priceInfo = args['priceInfo'];
    locationInfo = args['locationInfo'];
    distanceInfo = args['distanceInfo'];
    starInfo = args['starInfo'];
    countReviews = args['countReviews'];
    description = args['description'];
    locationSpecial = args['locationSpecial'];
    services = args['services'];
    id = args['id'];
    if (isFirst) {
      isFirst = false;
      isLike = args['isLike'];
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildItemHotelDetail(AssetHelper.hotelImageDetail),
              _buildItemHotelDetail(AssetHelper.hotelImageDetail),
              _buildItemHotelDetail(AssetHelper.hotelImageDetail),
            ],
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding * 4,
              horizontal: kDefaultPadding * 2.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop([null]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(kItemPadding),
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultPadding)),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.black,
                      size: kDefaultIconSize,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HotelDetailScreenController().likeHotel(id).then((value) => {
                    if (value.runtimeType == bool) {
                      isLike = value,
                      setState((){}),
                    }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(kItemPadding),
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(kDefaultPadding)),
                      color: Colors.white,
                    ),
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: isLike ? Colors.red : const Color(0xffF5DCDC),
                      size: kDefaultIconSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            maxChildSize: 1,
            minChildSize: 0.25,
            builder: (context, scrollController) {
              return ListView(
                controller: scrollController,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: kDefaultPadding),
                    child: SmoothPageIndicator(
                        controller: _pageController,
                        count: pageCount,
                        effect: const ExpandingDotsEffect(
                          dotWidth: kDefaultPadding / 2,
                          dotHeight: kDefaultPadding / 2,
                          activeDotColor: ColorPalette.primaryColor,
                        )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(kDefaultPadding * 1.5),
                          topRight: Radius.circular(kDefaultPadding * 1.5),
                        )),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: kMinPadding),
                          child: Container(
                            height: 5,
                            width: 80,
                            decoration: BoxDecoration(
                              color: ColorPalette.primaryColor,
                              borderRadius: BorderRadius.circular(kItemPadding),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: kDefaultPadding,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin:
                                        const EdgeInsets.all(kDefaultPadding),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              name ?? '',
                                              style: TextStyles.defaultStyle
                                                  .bold.blackTextColor
                                                  .setTextSize(
                                                      kDefaultTextSize * 1.1),
                                            ),
                                            Row(children: [
                                              Text(
                                                '\$$priceInfo',
                                                style: TextStyles.defaultStyle
                                                    .bold.blackTextColor
                                                    .setTextSize(
                                                        kDefaultTextSize * 1.1),
                                              ),
                                              Text(
                                                LocalizationText.night,
                                                style: TextStyles
                                                    .defaultStyle
                                                    .medium
                                                    .medium
                                                    .blackTextColor
                                                    .setTextSize(
                                                        kDefaultTextSize / 2),
                                              ),
                                            ])
                                          ],
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: kDefaultPadding / 6),
                                              child: const Icon(
                                                FontAwesomeIcons.locationDot,
                                                color: Color(0xFFF77777),
                                                size: kDefaultIconSize / 1.2,
                                              ),
                                            ),
                                            Text(
                                              locationInfo ?? '',
                                              style: TextStyles.defaultStyle
                                                  .blackTextColor.medium
                                                  .setTextSize(
                                                      kDefaultTextSize / 1.4),
                                            ),
                                            Text(
                                              ' -- $distanceInfo ${LocalizationText.fromDestination}',
                                              style: TextStyles.defaultStyle
                                                  .blackTextColor.light
                                                  .setTextSize(
                                                      kDefaultTextSize / 2.0),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromARGB(255, 123, 22, 22),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right:
                                                          kDefaultPadding / 5),
                                                  child: const Icon(
                                                    FontAwesomeIcons.solidStar,
                                                    color: Color(0xFFFFC107),
                                                    size:
                                                        kDefaultIconSize / 1.2,
                                                  ),
                                                ),
                                                Text(
                                                  '$starInfo/5',
                                                  style: TextStyles.defaultStyle
                                                      .blackTextColor.medium
                                                      .setTextSize(
                                                          kDefaultTextSize /
                                                              1.2),
                                                ),
                                                Text(
                                                  ' ($countReviews ${LocalizationText.reviews})',
                                                  style: TextStyles.defaultStyle
                                                      .blackTextColor.light
                                                      .setTextSize(
                                                          kDefaultTextSize /
                                                              1.2),
                                                )
                                              ],
                                            ),
                                            Text(
                                              LocalizationText.seeAll,
                                              style: TextStyles.defaultStyle
                                                  .bold.primaryTextColor
                                                  .setTextSize(
                                                      kDefaultTextSize),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromARGB(255, 123, 22, 22),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        Text(
                                          LocalizationText.information,
                                          style: TextStyles
                                              .defaultStyle.bold.blackTextColor
                                              .setTextSize(
                                                  kDefaultTextSize * 1),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding / 1.5,
                                        ),
                                        Text(
                                          description ?? '',
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          style: TextStyles.defaultStyle.regular
                                              .blackTextColor
                                              .setTextSize(
                                                  kDefaultTextSize / 1.2),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        Row(
                                          children: List.generate(4, (index) {
                                            return ServiceLoadHelper
                                                .serviceWidget(
                                                    services![index]);
                                          }),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        Text(
                                          LocalizationText.location,
                                          style: TextStyles
                                              .defaultStyle.bold.blackTextColor
                                              .setTextSize(
                                                  kDefaultTextSize * 1),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding / 1.5,
                                        ),
                                        Text(
                                          locationSpecial ?? '',
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          style: TextStyles.defaultStyle.regular
                                              .blackTextColor
                                              .setTextSize(
                                                  kDefaultTextSize / 1.2),
                                        ),
                                        const SizedBox(
                                          height: kDefaultPadding,
                                        ),
                                        ImageHelper.loadFromAsset(
                                          AssetHelper.locationTest,
                                          radius: BorderRadius.circular(
                                              kItemPadding),
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 20,
            child: Container(
              height: 50,
              width: 200,
              child: ButtonWidget(
                title: LocalizationText.selectRoom,
                ontap: () {
                  Navigator.pushNamed(context, SelectRoomScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
