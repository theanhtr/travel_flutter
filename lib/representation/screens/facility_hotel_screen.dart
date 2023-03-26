import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';
import '../../helpers/asset_helper.dart';

class FacilityHotel extends StatefulWidget {
  const FacilityHotel({super.key});
  static const String routeName = '/facility_hotel_screen';

  @override
  State<FacilityHotel> createState() => _FacilityHotelState();
}

class _FacilityHotelState extends State<FacilityHotel> {
  List<RowDetailFacilityHotel> selectedRows = [];
  List<RowDetailFacilityHotel> Rows = [
    RowDetailFacilityHotel(
      facility: "Wifi",
      icon: ImageHelper.loadFromAsset(AssetHelper.wifiIcon,
          fit: BoxFit.contain, width: kDefaultPadding * 1.5),
      checkBoxValue: false,
      index: 0,
    ),
    RowDetailFacilityHotel(
        facility: "Digital TV",
        icon: ImageHelper.loadFromAsset(AssetHelper.digitalTv,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 1),
    RowDetailFacilityHotel(
        facility: "Parking Area",
        icon: ImageHelper.loadFromAsset(AssetHelper.parkingAreaIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 2),
    RowDetailFacilityHotel(
        facility: "Swimming Pool",
        icon: ImageHelper.loadFromAsset(AssetHelper.swimingPoolIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 3),
    RowDetailFacilityHotel(
        facility: "Currency Exchange",
        icon: ImageHelper.loadFromAsset(AssetHelper.currencyExchangeIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 4),
    RowDetailFacilityHotel(
        facility: "Restaurant",
        icon: ImageHelper.loadFromAsset(AssetHelper.restaurantIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 5),
    RowDetailFacilityHotel(
        facility: "Car rental",
        icon: ImageHelper.loadFromAsset(AssetHelper.carRentalIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 6),
    RowDetailFacilityHotel(
        facility: "24-hour Front Desk",
        icon: ImageHelper.loadFromAsset(AssetHelper.receptionIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 7)
  ];

  @override
  Widget build(BuildContext context) {
    print("chay laij");
    return AppBarContainer(
        implementLeading: true,
        titleString: "Facility",
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: kMediumPadding * 3,
                ),
                StatefulBuilder(builder: (context, setState) {
                  return Container(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              this.setState(() {
                                for (var i = 0; i < Rows.length; i++)
                                  Rows[i].checkBoxValue = true;

                                print(Rows[5].checkBoxValue);
                                selectedRows.addAll(Rows);
                              });
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Select all",
                                    style: TextStyle(
                                      color: hexToColor(kDefaultTextColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  );
                }),
                for (var item in Rows) item,
                Container(
                  margin: const EdgeInsets.only(top: kDefaultPadding),
                  child: ButtonWidget(
                    title: 'Apply',
                    ontap: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
