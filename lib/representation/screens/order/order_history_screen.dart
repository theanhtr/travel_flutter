import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/order/HotelDetailFromOrderHistoryScreen.dart';
import 'package:travel_app_ytb/representation/screens/order/order_history_controller.dart';
import 'package:travel_app_ytb/representation/screens/order/order_history_item.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../../helpers/date_helper.dart';
import '../../widgets/loading/loading.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  static const String routeName = "/order_history_screen";

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<OrderHotelModel> listOrder = [];
  bool isLoaded = true;

  @override
  void initState() {
    super.initState();
    OrderHistoryController().getAllHotelOrder().then((value) => {
      setState(() {
        isLoaded = false;
        listOrder = value;
      }),
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        titleString: LocalizationText.orderHistory,
        implementLeading: true,
        child: isLoaded == true ? Loading.centerLoadingWidget : ListView(
            children: listOrder
                .map((e) => Column(
              children: [
                OrderHistoryItem(
                  onTap: () {
                    debugPrint("${e.orderStatusId}     ${e.orderStatusName}");
                    Navigator.pushNamed(
                        context, HotelDetailFromOrderHistoryScreen.routeName, arguments: {
                      'hotelId': e.hotelId,
                      'orderStatusId': e.orderStatusId,
                    });
                  },
                  widthContainer:
                  MediaQuery.of(context).size.width * 0.9,
                  name: e.hotelName ?? "",
                  orderStatusId: e.orderStatusId ?? 1,
                  orderStatusName: e.orderStatusName ?? "",
                  reviewed: e.reviewed ?? false,
                  typeRoomName: e.typeRoomName ?? "",
                  roomSize: e.typeRoomSize ?? 0,
                  priceInfo: e.totalPrice ?? 0,
                  numberOfBed: e.typeRoomNumberOfBeds ?? 0,
                  totalPrice: e.totalPrice ?? 0.0,
                  roomCount: e.roomQuantity ?? 0,
                  checkInDate: DateHelper().convertDateString(
                      dateString: e.checkInDate ?? "",
                      inputFormat: "yyyy-MM-dd HH:mm:ss") ??
                      "",
                  checkOutDate: DateHelper().convertDateString(
                      dateString: e.checkOUtDate ?? "",
                      inputFormat: "yyyy-MM-dd HH:mm:ss") ??
                      "",
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ))
                .toList()));
  }
}