import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';
import '../../helpers/asset_helper.dart';

class FacilityFlight extends StatefulWidget {
  const FacilityFlight({super.key});
  static const String routeName = '/facility_flight_screen';

  @override
  State<FacilityFlight> createState() => _FacilityFlightState();
}

class _FacilityFlightState extends State<FacilityFlight> {
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
        facility: "Baggage",
        icon: ImageHelper.loadFromAsset(AssetHelper.luggageIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 1),
    _CheckBoxState(
        facility: "Power / USB Port",
        icon: ImageHelper.loadFromAsset(AssetHelper.energyIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 2),
    _CheckBoxState(
        facility: "In-Flight Meal",
        icon: ImageHelper.loadFromAsset(AssetHelper.restaurantIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        implementLeading: true,
        titleString: LocalizationText.facility,
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
                                text: LocalizationText.selectAll,
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
                itemExtent: 84.0,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [...listCheckbox.map(buildItemCheckbox).toList()],
              ),
              Container(
                margin: const EdgeInsets.only(top: kDefaultPadding),
                child: ButtonWidget(
                  title: LocalizationText.apply,
                  ontap: () {},
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildItemCheckbox(_CheckBoxState checkBoxSate) =>
      RowDetailFacilityHotel(
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

  _CheckBoxState(
      {required this.facility,
      required this.icon,
      required this.index,
      this.checkBoxValue = false});
}
