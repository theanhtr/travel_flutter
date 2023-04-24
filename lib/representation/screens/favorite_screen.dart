import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/representation/controllers/favorite_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail/hotel_detail_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../core/utils/const_utils.dart';
import '../controllers/search_hotels_screen_controller.dart';
import '../models/hotel_model.dart';
import '../widgets/hotel_card_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<HotelModel> listHotel = [];
  List<dynamic> hotels = [];
  SearchHotelsScreenController? _controller;
  String currentPosition = "";
  List<HotelCardWidget> listHotelCardWidget = [];
  bool isFirst = true;
  bool _isLoading = false;
  bool _canLoadCardView = false;
  int isDone = 0;

  @override
  void initState() {
    super.initState();
    _controller = SearchHotelsScreenController();
  }

  @override
  Widget build(BuildContext context) {
    print('KKKK $isFirst');
    if (isFirst) {
      FavoriteScreenController().getAllHotelsLike().then((value) => {
            if (value.runtimeType == List<dynamic>)
              {
                hotels = value,
                if (!_isLoading)
                  {
                    _isLoading = true,
                    listHotel = [],
                    hotels.forEach((element) {
                      List<dynamic> images = element['images'];
                      String imagePath = "";
                      if (images.isEmpty) {
                        imagePath = ConstUtils.imgHotelDefault;
                      } else {
                        imagePath = element['images'][0]['path'] ?? "";
                      }
                      String address =
                          "${element['address']['specific_address']}, ${element['address']['sub_district']}, ${element['address']['district']}, ${element['address']['province']}";
                      double distanceInfo = 0;
                      HotelModel hotel = HotelModel(
                        imageFilePath: imagePath,
                        name: element['name'],
                        address: address,
                        locationInfo: element['address_id'].toString(),
                        distanceInfo: distanceInfo.toString(),
                        starInfo: element['rating_average'] + 0.0,
                        countReviews: element['count_review'],
                        priceInfo:
                            "${element['min_price']} - ${element['max_price']}",
                        id: element['id'],
                      );
                      listHotel.add(hotel);
                    }),
                  },
                listHotel.forEach((element) {
                  _controller
                      ?.getDistanceInformation(element.address ?? "")
                      .then((value) => {
                            element.distanceInfo = value.toString(),
                          });
                }),
                _canLoadCardView = true,
                if (_canLoadCardView == true)
                  {
                    _canLoadCardView = false,
                    listHotelCardWidget = [],
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
                        ontap: () async {
                          await Navigator.pushNamed(
                              context, HotelDetailScreen.routeName,
                              arguments: {
                                'id': element.id,
                                'name': element.name ?? "",
                                'priceInfo': element.priceInfo ?? "",
                                'locationInfo': element.locationInfo ?? "",
                                'distanceInfo': element.distanceInfo ?? "",
                                'starInfo': element.starInfo ?? 0.0,
                                'countReviews': element.countReviews ?? 0,
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
                                'isLike': true,
                              });
                          setState(() {});
                        },
                      ));
                    }),
                  },
                isFirst = false,
                isDone = 1,
                setState(() {}),
              },
          });
    }
    isFirst = true;
    _isLoading = false;
    _canLoadCardView = false;
    print('length ${listHotelCardWidget.length}');
    return AppBarContainer(
      titleString: 'Favorite',
      child: SingleChildScrollView(
        child: (isDone-- > 0)
            ? listHotelCardWidget.isNotEmpty
                ? Column(
                    children: listHotelCardWidget,
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 200),
                    child: const Center(
                      child: Text(
                        'Your favorite hotel list is empty',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  )
            : const SpinKitCircle(
                color: Colors.black,
                size: 64.0,
              ),
      ),
    )
        //   Center(
        //   child: Text(
        //     currentPosition,
        //     style: TextStyle(
        //       color: Colors.black
        //     ),
        //   ),
        // )
        ;
  }
}
