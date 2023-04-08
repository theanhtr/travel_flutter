import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';
import '../../helpers/asset_helper.dart';

class SortByFlight extends StatefulWidget {
  const SortByFlight({super.key});
  static const String routename = '/sort_by_flight_screen';

  @override
  State<SortByFlight> createState() => _SortByFlightState();
}

class _SortByFlightState extends State<SortByFlight> {
  bool isSelectedAll = true;
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(facility: "Earliest Departure", icon: Container(), index: 1),
    _CheckBoxState(facility: "Latest Departure", icon: Container(), index: 2),
    _CheckBoxState(facility: "Earliest Arrive", icon: Container(), index: 3),
    _CheckBoxState(facility: "Latest Arrive", icon: Container(), index: 4),
    _CheckBoxState(facility: "Shortest Duration", icon: Container(), index: 0),
    _CheckBoxState(facility: "Lowest Price", icon: Container(), index: 0),
    _CheckBoxState(facility: "Highest popularity", icon: Container(), index: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        implementLeading: true,
        titleString: "Sort by",
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kMediumPadding * 3,
              ),
              ListView(
                itemExtent: 84.0,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [...listCheckbox.map(buildItemCheckbox).toList()],
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
