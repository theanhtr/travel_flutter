import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/core/utils/navigation_utils.dart';
import 'package:travel_app_ytb/helpers/adminManager/admin_manager.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/helpers/service_load_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/hotel_model.dart';
import 'package:travel_app_ytb/representation/widgets/google/google_map_widget.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail/hotel_detail_controller.dart';
import 'package:travel_app_ytb/representation/screens/room_booking/select_room_screen.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../../widgets/tapable_widget.dart';
import '../reviews/reviews_screen.dart';

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
  HotelModel? _hotelModel;
  HotelDetailController? _controller;
  bool _isLoading = true;
  String _dateSelected = "";
  int _guestCount = 1;
  int _roomCount = 1;

  final PageController _pageController = PageController();
  int pageCount = 1;
  final AdminManager _adminManager = AdminManager();
  final StreamController<double> _pageStreamController =
      StreamController<double>.broadcast();

  @override
  void initState() {
    super.initState();
    _controller = HotelDetailController();
    //hàm chạy vào mỗi khi có sự kiện
  }

  Future<void> _initData(int id) async {
    if (_isLoading == true) {
      _controller?.getHotelDetail(id).then(
            (value) => {
              print(
                  "Lenght ow hotel detail screen: ${value.listImageDetailPath} "),
              setState(() {
                _hotelModel = value;
                LocationHelper()
                    .getGeoPointFromAddress(_hotelModel?.address ?? "")
                    .then((position) => {
                      debugPrint("79 hotel detail $position"),
                          setState(() {
                            _hotelModel?.position =
                                LatLng(position.latitude, position.longitude);
                            isLike = _hotelModel?.isLike ?? true;
                          })
                        });
                pageCount = value.listImageDetailPath?.length ?? 1;
                _pageController.addListener(() {
                  _pageStreamController.add(_pageController.page!.toDouble());
                });
              }),
              _isLoading = false,
            },
          );
    }
  }

  Widget _buildItemHotelDetail(String imagePath) {
    return Container(
      child: ImageHelper.loadFromNetwork(imagePath, fit: BoxFit.fitHeight),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = NavigationUtils.getArguments(context);
    final id = args['hotelId'] as int;
    _dateSelected = args['dateSelected'] as String;
    _guestCount = args['guestCount'];
    _roomCount = args['roomCount'];
    _hotelModel?.distanceInfo = args['distanceInfo'];
    _initData(id);
    return Scaffold(
      body: _isLoading == false
          ? Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  controller: _pageController,
                  children: [
                    for (String imagePath
                        in _hotelModel?.listImageDetailPath ?? [])
                      _buildItemHotelDetail(imagePath),
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(kDefaultPadding)),
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
                          _controller?.likeHotel(id).then((value) => {
                                if (value.runtimeType == bool)
                                  {
                                    isLike = value,
                                    setState(() {}),
                                  }
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(kItemPadding),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(kDefaultPadding)),
                            color: Colors.white,
                          ),
                          child: Icon(
                            FontAwesomeIcons.solidHeart,
                            color:
                                isLike ? Colors.red : const Color(0xffF5DCDC),
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
                          margin:
                              const EdgeInsets.only(bottom: kDefaultPadding),
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
                                topRight:
                                    Radius.circular(kDefaultPadding * 1.5),
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
                                    borderRadius:
                                        BorderRadius.circular(kItemPadding),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.all(
                                            kDefaultPadding),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  _hotelModel?.name ?? '',
                                                  style: TextStyles.defaultStyle
                                                      .bold.blackTextColor
                                                      .setTextSize(
                                                          kDefaultTextSize *
                                                              1.1),
                                                ),
                                                Row(children: [
                                                  Text(
                                                    '\$${_hotelModel?.priceInfo}',
                                                    style: TextStyles
                                                        .defaultStyle
                                                        .bold
                                                        .blackTextColor
                                                        .setTextSize(
                                                            kDefaultTextSize *
                                                                1.1),
                                                  ),
                                                  Text(
                                                    '/night',
                                                    style: TextStyles
                                                        .defaultStyle
                                                        .medium
                                                        .medium
                                                        .blackTextColor
                                                        .setTextSize(
                                                            kDefaultTextSize /
                                                                2),
                                                  ),
                                                ])
                                              ],
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            Wrap(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right:
                                                          kDefaultPadding / 6),
                                                  child: const Icon(
                                                    FontAwesomeIcons
                                                        .locationDot,
                                                    color: Color(0xFFF77777),
                                                    size:
                                                        kDefaultIconSize / 1.2,
                                                  ),
                                                ),
                                                Text(
                                                  _hotelModel?.locationInfo ??
                                                      '',
                                                  style: TextStyles.defaultStyle
                                                      .blackTextColor.medium
                                                      .setTextSize(
                                                          kDefaultTextSize /
                                                              1.4),
                                                ),
                                                Text(
                                                  ' -- ${_hotelModel?.distanceInfo} ${LocalizationText.fromDestination}',
                                                  style: TextStyles.defaultStyle
                                                      .blackTextColor.light
                                                      .setTextSize(
                                                          kDefaultTextSize /
                                                              2.0),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            const Divider(
                                              color: Color.fromARGB(
                                                  255, 123, 22, 22),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .only(
                                                          right:
                                                              kDefaultPadding /
                                                                  5),
                                                      child: const Icon(
                                                        FontAwesomeIcons
                                                            .solidStar,
                                                        color:
                                                            Color(0xFFFFC107),
                                                        size: kDefaultIconSize /
                                                            1.2,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${_hotelModel?.starInfo}/5',
                                                      style: TextStyles
                                                          .defaultStyle
                                                          .blackTextColor
                                                          .medium
                                                          .setTextSize(
                                                              kDefaultTextSize /
                                                                  1.2),
                                                    ),
                                                    Text(
                                                      ' (${_hotelModel?.countReviews} ${LocalizationText.reviews})',
                                                      style: TextStyles
                                                          .defaultStyle
                                                          .blackTextColor
                                                          .light
                                                          .setTextSize(
                                                              kDefaultTextSize /
                                                                  1.2),
                                                    )
                                                  ],
                                                ),
                                                TapableWidget(
                                                  child: Text(
                                                    'See All',
                                                    style: TextStyles
                                                        .defaultStyle
                                                        .bold
                                                        .primaryTextColor
                                                        .setTextSize(
                                                            kDefaultTextSize),
                                                  ),
                                                  onTap: () {
                                                    Navigator.pushNamed(context,
                                                        ReviewsScreen.routeName,
                                                        arguments: {
                                                          'id': id,
                                                        });
                                                  },
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            const Divider(
                                              color: Color.fromARGB(
                                                  255, 123, 22, 22),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            Text(
                                              LocalizationText.information,
                                              style: TextStyles.defaultStyle
                                                  .bold.blackTextColor
                                                  .setTextSize(
                                                      kDefaultTextSize * 1),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding / 1.5,
                                            ),
                                            Text(
                                              _hotelModel?.description ?? '',
                                              softWrap: true,
                                              textAlign: TextAlign.justify,
                                              style: TextStyles.defaultStyle
                                                  .regular.blackTextColor
                                                  .setTextSize(
                                                      kDefaultTextSize / 1.2),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            Row(
                                              children: List.generate(
                                                  _hotelModel
                                                          ?.services?.length ??
                                                      0, (index) {
                                                return ServiceLoadHelper
                                                    .serviceWidget(
                                                        _hotelModel?.services![
                                                                index] ??
                                                            "Error");
                                              }),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            Text(
                                              LocalizationText.location,
                                              style: TextStyles.defaultStyle
                                                  .bold.blackTextColor
                                                  .setTextSize(
                                                      kDefaultTextSize * 1),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding / 1.5,
                                            ),
                                            Text(
                                              _hotelModel?.locationSpecial ??
                                                  '',
                                              softWrap: true,
                                              textAlign: TextAlign.justify,
                                              style: TextStyles.defaultStyle
                                                  .regular.blackTextColor
                                                  .setTextSize(
                                                      kDefaultTextSize / 1.2),
                                            ),
                                            const SizedBox(
                                              height: kDefaultPadding,
                                            ),
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.9,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: _hotelModel?.position !=
                                                        null
                                                    ? GoogleMapWidget(
                                                        location: _hotelModel
                                                                ?.position ??
                                                            const LatLng(
                                                                10.8231,
                                                                106.6297),
                                                      )
                                                    : Builder(
                                                        builder: (BuildContext
                                                            loadGGContext) {
                                                          return Container(
                                                            child: Loading
                                                                .centerLoadingWidget,
                                                          );
                                                        },
                                                      )),
                                          ],
                                        ))
                                  ],
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
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: LocalStorageHelper.getValue("roleId") != 1
                        ? ButtonWidget(
                            title: LocalizationText.selectRoom,
                            ontap: () {
                              if (LocalStorageHelper.getValue("roleId") == 1) {
                                // _adminManager.deleteHotel(id);

                                print("cbi delete hotel day");
                              } else {
                                Navigator.pushNamed(
                                    context, SelectRoomScreen.routeName,
                                    arguments: {
                                      'hotelId': _hotelModel?.id,
                                      'dateSelected': _dateSelected,
                                      'guestCount': _guestCount,
                                      'roomCount': _roomCount,
                                    });
                              }
                            },
                          )
                        : SizedBox(
                            height: 0,
                          ),
                  ),
                ),
              ],
            )
          : const SpinKitCircle(
              color: Colors.black,
              size: 64.0,
            ),
    );
  }
}
