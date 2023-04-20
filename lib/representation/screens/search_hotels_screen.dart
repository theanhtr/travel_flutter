import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/hotel_card_widget.dart';
import 'package:travel_app_ytb/helpers/filterManager/filter_manager.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/constants/dismention_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../widgets/booking_hotel_tab_container.dart';
import '../widgets/button_widget.dart';
import '../widgets/loading/loading.dart';
import '../widgets/out_button_widget.dart';
import '../widgets/slider.dart';

class SearchHotelsScreen extends StatefulWidget {
  const SearchHotelsScreen({super.key});

  static const String routeName = '/search_hotels_screen';

  @override
  State<SearchHotelsScreen> createState() => _SearchHotelsScreenState();
}

class _SearchHotelsScreenState extends State<SearchHotelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AppBarContainer(
            titleString: 'Hotels',
            implementLeading: true,
            implementTrailing: true,
            widget: const ButtonInDialog(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HotelCardWidget(
                    widthContainer: MediaQuery.of(context).size.width * 0.9,
                    imageFilePath: AssetHelper.hotelImage1,
                    name: 'Royal Palm Heritage',
                    locationInfo: 'Purwokerto, Jateng',
                    distanceInfo: '365 m',
                    starInfo: 4.5,
                    countReviews: 3123,
                    priceInfo: 145,
                    ontap: () async {
                      await Navigator.pushNamed(
                          context, HotelDetailScreen.routeName,
                          arguments: {
                            'name': 'Royal Palm Heritage',
                            'priceInfo': 145,
                            'locationInfo': 'Purwokerto, Jateng',
                            'distanceInfo': '365 m',
                            'starInfo': 4.5,
                            'countReviews': 3123,
                            'description':
                                'You will find every comfort because many of the services that the hotel offers for travellers and of course the hotel is very comfortable.',
                            'locationSpecial':
                                'Located in the famous neighborhood of Seoul, Grand Luxury is set in a building built in the 2010s.',
                            'services': <String>[
                              'Restaurant',
                              'Free Wifi',
                              'Currency Exchange',
                              'Private Pool',
                              '24-hour Font Desk'
                            ],
                          });
                    },
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  HotelCardWidget(
                    widthContainer: MediaQuery.of(context).size.width * 0.9,
                    imageFilePath: AssetHelper.hotelImage2,
                    name: 'Grand Luxury',
                    locationInfo: 'Hanoi, Jateng',
                    distanceInfo: '2.3 km',
                    starInfo: 4.2,
                    countReviews: 2623,
                    priceInfo: 415,
                    ontap: () {},
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  HotelCardWidget(
                    widthContainer: MediaQuery.of(context).size.width * 0.9,
                    imageFilePath: AssetHelper.hotelImage3,
                    name: 'Royal Palm Heritage',
                    locationInfo: 'TpHoChiMinh, Jateng',
                    distanceInfo: '365 km',
                    starInfo: 4.5,
                    countReviews: 3123,
                    priceInfo: 145,
                    ontap: () {},
                  ),
                  const SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                ],
              ),
            ),
          ),
        ],
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
  String budgetFrom = "0";
  String budgetTo = "1000";
  String ratingAverage = "1";
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
                                children: [
                                  Expanded(
                                    child: Material(
                                      color: const Color.fromARGB(
                                          255, 240, 242, 246),
                                      child: MySliderApp(
                                        initialFontSize: 20,
                                        start: 0,
                                        end: 1000,
                                        unit: "\$",
                                        divisions: 100,
                                        getBudget: (budgetFromT, budgetToT) {
                                          budgetFrom = budgetFromT;
                                          budgetTo = budgetToT;
                                        },
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
                                          ratingAverage = "1";
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
                                          ratingAverage = "2";
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
                                          ratingAverage = "3";
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
                                          ratingAverage = "4";
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
                                          ratingAverage = "5";
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
                                ontap: () {
                                  Loading.show(context);
                                  FilterManager()
                                      .filterHotels(
                                          budgetFrom, budgetTo, ratingAverage)
                                      .then((value) => {
                                            debugPrint(
                                                "value forgot password $value"),
                                            Loading.dismiss(context),
                                            if (value['success'] == true)
                                              {
                                                Loading.dismiss(context),
                                                Navigator.popAndPushNamed(context, SearchHotelsScreen.routeName, arguments: value['data'])
                                              }
                                            else if (value['result'] ==
                                                'statuscode 500')
                                              {
                                                Loading.dismiss(context),
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'YOU MUST ENTER YOUR EMAIL'),
                                                    content: const Text(''),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              }
                                            else if (value['result'] ==
                                                    'statuscode 400' ||
                                                value['result'] ==
                                                    'statuscode 401')
                                              {
                                                Loading.dismiss(context),
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'No user found with this email'),
                                                    content: const Text(''),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              },
                                            Loading.dismiss(context)
                                          });
                                },
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
