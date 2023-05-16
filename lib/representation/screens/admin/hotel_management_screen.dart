import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/search_hotels_screen_controller.dart';
import 'package:travel_app_ytb/representation/models/hotel_model.dart';
import 'package:travel_app_ytb/representation/screens/admin/hotel_card_management.dart';
import 'package:travel_app_ytb/representation/screens/hotel_detail/hotel_detail_screen.dart';

import 'package:travel_app_ytb/representation/widgets/hotel_card_widget.dart';

import '../../../core/utils/navigation_utils.dart';

class AdminManageHotel extends StatefulWidget {
  List<dynamic> hotelsList;
  AdminManageHotel({super.key, required this.hotelsList});

  @override
  State<AdminManageHotel> createState() => _AdminManageHotelState();
}

class _AdminManageHotelState extends State<AdminManageHotel> {
  bool isFirst = true;
  bool _isLoading = false;
  bool _canLoadCardView = false;
  bool _loadHotelListDone = false;
  int isDone = 0;
  List<HotelModel> listHotel = [];
  List<dynamic> hotels = [];
  SearchHotelsScreenController? _controller;
  String currentPosition = "";
  List<HotelCardWidget> listHotelCardWidget = [];
  dynamic elementDetail;
  int count = 0;
  @override
  void initState() {
    super.initState();
    _controller = SearchHotelsScreenController();
  }

  // _controller?.getHotelDetail(element["id"]).then((value) => {
  //             print("Value search dayyyyyyyyR"),
  //           });
  Future<void> _setCardList() async {
    listHotelCardWidget = [];
    print('length dong 47 ${listHotel.length} ');
    for (var element in listHotel) {
      await _controller?.getDistanceInformation(element.address ?? "").then(
          (value) => {
                listHotelCardWidget.add(HotelCardWidget(
                  widthContainer: MediaQuery.of(context).size.width * 0.9,
                  imageFilePath: element.imageFilePath ?? "",
                  name: element.name ?? "",
                  locationInfo: element.locationInfo ?? "",
                  distanceInfo: "$value km" ?? "",
                  starInfo: element.starInfo ?? 0.0,
                  countReviews: element.countReviews ?? 0,
                  priceInfo: element.priceInfo ?? "",
                  ontap: () async {
                    await NavigationUtils.navigate(
                        context, HotelDetailScreen.routeName,
                        arguments: {
                          "hotelId": element.id,
                          "distanceInfo": "$value km" ?? "",
                          'dateSelected': DateTime.now().toString(),
                          'guestCount': 1,
                          'roomCount': 1,
                        });

                    // NavigationUtils.navigate(
                    //     context, HotelDetailScreen.routeName,
                    //     arguments: {
                    //       "hotelId": element.id,
                    //       "distanceInfo": "$value km" ?? "",
                    //       'dateSelected': _dateSelected,
                    //       'guestCount': _guestCount,
                    //       'roomCount': _roomCount,
                    //     });
                  },
                )),
              },
          onError: (error) => {
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
                    await NavigationUtils.navigate(
                        context, HotelDetailScreen.routeName,
                        arguments: {
                          "hotelId": element.id,
                          "distanceInfo": "0",
                          'dateSelected': DateTime.now().toString(),
                          'guestCount': 1,
                          'roomCount': 1,
                        });
                  },
                )),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('KKKK $isFirst');
    // print("hotel dong 22: ${elementDetail}");

    if (isFirst) {
      // print('is loadnig $_isLoading');
      hotels = widget.hotelsList;
      if (!_isLoading && !_loadHotelListDone) {
        // print('dang chạy loading đâyyyyyy');
        _isLoading = true;
        listHotel = [];
        // print('lengthfffffffffffff ${hotels}');
        List<dynamic> images;
        String imagePath = "";
        String address;
        double distanceInfo = 0;
        HotelModel hotel;
        hotels.forEach((element) async {
          // print("hotel dong 22:  ${element["id"]}");
          await _controller?.getHotelDetail(element["id"]).then((value) => {
                count++,
                // print("Value search dayyyyyyyyR"),
                elementDetail = value,
                images = elementDetail['images'],
                address =
                    "${elementDetail['address']['specific_address']}, ${elementDetail['address']['sub_district']}, ${elementDetail['address']['district']}, ${elementDetail['address']['province']}",
                if (images.isEmpty)
                  {
                    imagePath = ConstUtils.imgHotelDefault,
                  }
                else
                  {
                    imagePath = elementDetail['images'][0]['path'] ?? "",
                  },
                hotel = HotelModel(
                  imageFilePath: imagePath,
                  name: elementDetail['name'],
                  address: address,
                  locationInfo: elementDetail['address_id'].toString(),
                  distanceInfo: distanceInfo.toString(),
                  starInfo: elementDetail['rating_average'] + 0.0,
                  countReviews: elementDetail['count_review'],
                  priceInfo:
                      "${elementDetail['min_price']} - ${elementDetail['max_price']}",
                  id: elementDetail['id'],
                ),
                listHotel.add(hotel),
                print('length cua listhotel dong 90  ${listHotel.length}'),
              });
          // print("hotel dong 47 element detailllll: ${elementDetail}");

          // print('KKKK im here');
          if (count == hotels.length) {
            setState(() {
              _loadHotelListDone = true;
            });
          }
        });
        // print('length cua listhotel ${listHotel.length}');
      }
      // print('length dong 87 ${listHotel.length} va is loadnig $_isLoading');

      _canLoadCardView = true;
      if (_canLoadCardView == true && _loadHotelListDone && isDone != 1) {
        _canLoadCardView = false;
        listHotelCardWidget = [];
        // print("hotel dong 76666666666666666666666666666: ${listHotel[0].id}");
        if (listHotel.length > 0) {
          _setCardList().then((value) => {isDone = 1, setState(() {})});
        }
      }
    }

    if (isDone == 1) {
      isFirst = true;
      _isLoading = false;
      _canLoadCardView = false;
    }

    // print("hotel dong 22: ${widget.hotelsList}");
    // print('lengthfffffffffffff 198 ${listHotelCardWidget.length}');
    return SingleChildScrollView(
      child: (isDone-- > 0)
          ? listHotelCardWidget.isNotEmpty
              ? Column(
                  children: listHotelCardWidget,
                )
              : Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: Center(
                    child: Text(
                      LocalizationText.noHotel,
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
    );
  }
}
