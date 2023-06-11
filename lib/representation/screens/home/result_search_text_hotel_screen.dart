import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/home/search_in_home_controller.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../../core/utils/const_utils.dart';
import '../../../core/utils/navigation_utils.dart';
import '../../../helpers/location/location_helper.dart';
import '../../models/hotel_model.dart';
import '../../widgets/hotel_card_widget.dart';
import '../favorite_booking_screen.dart';
import '../hotel_booking/search_hotels_screen.dart';

class ResultSearchTextHotelScreen extends StatefulWidget {
  const ResultSearchTextHotelScreen({super.key});

  static const String routeName = '/result_search_text_hotel_screen';

  @override
  State<ResultSearchTextHotelScreen> createState() => _ResultSearchTextHotelScreenState();
}

class _ResultSearchTextHotelScreenState extends State<ResultSearchTextHotelScreen> {
  Map<String, dynamic> args = <String, dynamic>{};
  List<HotelModel> listHotel = [];
  List<dynamic> hotels = [];
  SearchInHomeController? _controller;
  String currentPosition = "";
  List<HotelCardWidget> listHotelCardWidget = [];
  bool isFirst = true;
  bool _isLoading = false;
  bool _canLoadCardView = false;
  int isDone = 0;
  final String _dateSelected = "";
  final int _guestCount = 1;
  final int _roomCount = 1;

  @override
  void initState() {
    super.initState();
    _controller = SearchInHomeController();
  }

  Future<void> _setCardList() async {
    for (var element in listHotel) {
      await LocationHelper().getDistanceInformation(element.address ?? "").then(
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
                    context, FavoriteBookingScreen.routeName,
                    arguments: {
                      "hotelId": element.id,
                      "distanceInfo": "$value km" ?? "",
                      'dateSelected': _dateSelected,
                      'guestCount': _guestCount,
                      'roomCount': _roomCount,
                    });
                setState(() {});
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
                    context, FavoriteBookingScreen.routeName,
                    arguments: {
                      "hotelId": element.id,
                      "distanceInfo": "0",
                      'dateSelected': _dateSelected,
                      'guestCount': _guestCount,
                      'roomCount': _roomCount,
                    });
                setState(() {});
                // NavigationUtils.navigate(
                //     context, HotelDetailScreen.routeName,
                //     arguments: {
                //       "hotelId": element.id,
                //       "distanceInfo": "0",
                //       'dateSelected': _dateSelected,
                //       'guestCount': _guestCount,
                //       'roomCount': _roomCount,
                //     });
              },
            )),
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    String textSearch = NavigationUtils.getArguments(context);
    if (isFirst) {
      isFirst = false;
      _controller?.searchHotelByText(textSearch).then((value) => {
        debugPrint("122 $value"),
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
            _canLoadCardView = true,
            if (_canLoadCardView == true)
              {
                _canLoadCardView = false,
                listHotelCardWidget = [],
                print('PPPPPPP ${listHotel.length}'),
                _setCardList()
                    .then((value) => {isDone = 1, setState(() {})}),
              },
          },
        if (value.runtimeType == int) {
          setState((){
            hotels = [];
            isDone = 1;
            debugPrint("170 $value");
          }),
        }
      });
    }
    if (isDone == 1) {
      isFirst = true;
      _isLoading = false;
      _canLoadCardView = false;
    }
    print('length ${listHotelCardWidget.length}');
    return AppBarContainer(
      titleString: LocalizationText.hotels,
      implementLeading: true,
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
