import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/search_hotels_screen_controller.dart';
import 'package:travel_app_ytb/representation/models/hotel_model.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/hotel_card_widget.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dismention_constants.dart';
import '../../../core/constants/textstyle_constants.dart';
import '../../../helpers/image_helper.dart';
import '../../widgets/booking_hotel_tab_container.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/slider.dart';

class SearchHotelsScreen extends StatefulWidget {
  const SearchHotelsScreen({super.key});

  static const String routeName = '/search_hotels_screen';

  @override
  State<SearchHotelsScreen> createState() => _SearchHotelsScreenState();
}

class _SearchHotelsScreenState extends State<SearchHotelsScreen> {
  final List<HotelModel> listHotel = [];
  final List<HotelCardWidget> listHotelCardWidget = [];
  bool _isLoading = false;
  bool _canLoadCardView = false;
  List<dynamic> hotels = [];
  SearchHotelsScreenController? _controller;

  @override
  void initState() {
    super.initState();
    LocationHelper().determinePosition();
    _controller = SearchHotelsScreenController();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    hotels = args['listHotels'];
    if (_isLoading == false) {
      hotels.forEach((element) {
        List<dynamic> images = element['images'];
        String imagePath = "";
        if (images.isEmpty) {
          imagePath =
              "https://cf.bstatic.com/images/hotel/max1024x768/378/378828506.jpg";
        } else {
          imagePath = element['images'][0]['path'] ?? "";
        }
        String address =
            "${element['address']['specific_address']}, ${element['address']['province']}, ${element['address']['district']}, ${element['address']['sub_district']}";
        double distanceInfo = 0;
        HotelModel hotel = HotelModel(
          imageFilePath: imagePath,
          name: element['name'],
          address: address,
          locationInfo: element['address_id'].toString(),
          distanceInfo: distanceInfo.toString(),
          starInfo: element['rating_average'] + 0.0,
          countReviews: element['count_review'],
          priceInfo: "${element['min_price']} - ${element['max_price']}",
        );
        listHotel.add(hotel);
      });
      _isLoading = true;
    }

    listHotel.forEach((element) {
      _controller?.getDistanceInformation(element.address ?? "")
          .then((value) => {
                element.distanceInfo = value.toString(),
              });
    });
    _canLoadCardView = true;
    if (_canLoadCardView == true) {
      listHotel.forEach((element) {
        listHotelCardWidget.add(HotelCardWidget(
          widthContainer: MediaQuery.of(context).size.width * 0.9,
          imageFilePath: element.imageFilePath ?? "",
          name: element.name ?? "",
          locationInfo: element.locationInfo ?? "",
          distanceInfo: element.distanceInfo ?? "",
          starInfo: element.starInfo ?? 0.0,
          countReviews: element.countReviews ?? 0,
          priceInfo: element.priceInfo ?? "",
          ontap: () {},
        ));
      });
      _canLoadCardView = false;
    }

    //debugPrint("list hotel ${listHotel[0].distanceInfo}");
    return AppBarContainer(
      titleString: LocalizationText.hotels,
      implementLeading: true,
      implementTrailing: true,
      child: SingleChildScrollView(
        child: Column(
            children: listHotelCardWidget
            ),
      ),
    );
  }
}

class ButtonInDialog extends StatefulWidget {
  const ButtonInDialog({super.key});

  @override
  State<ButtonInDialog> createState() => _ButtonInDialogState();
}

class _ButtonInDialogState extends State<ButtonInDialog> {
  var isYellow1 = false;
  var isYellow2 = false;
  var isYellow3 = false;
  var isYellow4 = false;
  var isYellow5 = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      maxChildSize: 1,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 242, 246),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Choose Your Filter',
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize * 1.2),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                'Budget',
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize - 2),
                              ),
                              const SizedBox(
                                height: kMediumPadding * 1.5,
                              ),
                              Row(
                                children: const [
                                  Expanded(
                                    child: Material(
                                      color: Color.fromARGB(255, 240, 242, 246),
                                      child: MySliderApp(
                                        initialFontSize: 20,
                                        start: 0,
                                        end: 1000,
                                        unit: "\$",
                                        divisions: 100,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                'Hotel Class',
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize - 2),
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isYellow1 = true;
                                          isYellow2 = false;
                                          isYellow3 = false;
                                          isYellow4 = false;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow1
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = false;
                                          isYellow4 = false;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow2
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = true;
                                          isYellow4 = false;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow3
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = true;
                                          isYellow4 = true;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow4
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = true;
                                          isYellow4 = true;
                                          isYellow5 = true;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow5
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              Column(
                                children: [
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.suitcaseMedical,
                                    title: 'Facilities',
                                    description: '',
                                    sizeItem: kDefaultIconSize / 1.5,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color(0xffFE9C5E),
                                    secondaryColor: const Color(0xffFE9C5E)
                                        .withOpacity(0.2),
                                    iconString: AssetHelper.wifiIcon,
                                    useIconString: '',
                                    bordered: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.sort,
                                    title: 'Property Type',
                                    description: "",
                                    sizeItem: kDefaultIconSize / 1.5,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color.fromARGB(
                                        255, 113, 228, 155),
                                    secondaryColor:
                                        const Color.fromARGB(255, 126, 235, 193)
                                            .withOpacity(0.2),
                                    iconString: AssetHelper.skyscraperIcon,
                                    useIconString: '',
                                    bordered: '',
                                  ),
                                  const SizedBox(
                                    height: kDefaultPadding,
                                  ),
                                  BookingHotelTab(
                                    icon: FontAwesomeIcons.sort,
                                    title: 'Sort By',
                                    description: "",
                                    sizeItem: kDefaultIconSize / 1.5,
                                    sizeText: kDefaultIconSize / 1.2,
                                    primaryColor: const Color.fromARGB(
                                        255, 113, 228, 155),
                                    secondaryColor:
                                        const Color.fromARGB(255, 126, 235, 193)
                                            .withOpacity(0.2),
                                    iconString: 'id',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              ButtonWidget(
                                title: 'Apply',
                                ontap: () {},
                              ),
                              const SizedBox(
                                height: kMinPadding,
                              ),
                              ButtonWidget(
                                title: 'Reset',
                                ontap: () {},
                              ),
                              // ButtonWidget(
                              //   title: 'Book a room',
                              //   ontap: () {
                              //     Navigator.of(context)
                              //         .pushNamed(HotelFilterScreen.routeName);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
