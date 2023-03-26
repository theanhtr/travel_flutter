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
  bool isSelectedAll = true;
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(
      facility: "Wifi",
      icon: ImageHelper.loadFromAsset(AssetHelper.wifiIcon,
          fit: BoxFit.contain, width: kDefaultPadding * 1.5),
      checkBoxValue: false,
      index: 0,
    ),
    _CheckBoxState(
        facility: "Digital TV",
        icon: ImageHelper.loadFromAsset(AssetHelper.digitalTv,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 1),
    _CheckBoxState(
        facility: "Parking Area",
        icon: ImageHelper.loadFromAsset(AssetHelper.parkingAreaIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 2),
    _CheckBoxState(
        facility: "Swimming Pool",
        icon: ImageHelper.loadFromAsset(AssetHelper.swimingPoolIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 3),
    _CheckBoxState(
        facility: "Currency Exchange",
        icon: ImageHelper.loadFromAsset(AssetHelper.currencyExchangeIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 4),
    _CheckBoxState(
        facility: "Restaurant",
        icon: ImageHelper.loadFromAsset(AssetHelper.restaurantIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 5),
    _CheckBoxState(
        facility: "Car rental",
        icon: ImageHelper.loadFromAsset(AssetHelper.carRentalIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 6),
    _CheckBoxState(
        facility: "24-hour Front Desk",
        icon: ImageHelper.loadFromAsset(AssetHelper.receptionIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 7)
  ];

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        implementLeading: true,
        titleString: "Facility",
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kMediumPadding * 3,
              ),
              StatefulBuilder(builder: (context, setState) {
                return Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          this.setState(() {
                            for (var i = 0; i < listCheckbox.length; i++) {
                              listCheckbox[i].checkBoxValue = isSelectedAll;
                            }
                            isSelectedAll = !isSelectedAll;
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
                ]);
              }),
              ListView(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  ...listCheckbox.map(buildItemCheckbox).toList()
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: kDefaultPadding),
                child: ButtonWidget(
                  title: 'Apply',
                  ontap: () {},
                ),
              ),
            ],
          ),
        ));
  }
  Widget buildItemCheckbox(_CheckBoxState checkBoxSate) => RowDetailFacilityHotel(
      facility: checkBoxSate.facility,
      icon: checkBoxSate.icon,
      checkBoxValue: checkBoxSate.checkBoxValue,
      index: checkBoxSate.index,
  );
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class _CheckBoxState {
  final String facility;
  final Widget icon;
  final int index;
  bool checkBoxValue;

  _CheckBoxState({required this.facility, required this.icon, required this.index, this.checkBoxValue = false});
}