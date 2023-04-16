import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';
import '../../helpers/asset_helper.dart';

class SortByHotel extends StatefulWidget {
  const SortByHotel({super.key});
  static const String routename = '/sort_by_hotel_screen';

  @override
  State<SortByHotel> createState() => _SortByHotelState();
}

class _SortByHotelState extends State<SortByHotel> {
  bool isSelectedAll = true;
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(
        facility: LocalizationText.highestPopularity,
        icon: Container(),
        index: 0),
    _CheckBoxState(
        facility: LocalizationText.lowestPrice, icon: Container(), index: 1),
    _CheckBoxState(
        facility: LocalizationText.highestPrice, icon: Container(), index: 2),
    _CheckBoxState(
        facility: LocalizationText.highestRating, icon: Container(), index: 3),
    _CheckBoxState(
        facility: LocalizationText.nearestDistance,
        icon: Container(),
        index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        implementLeading: true,
        titleString: LocalizationText.sortBy,
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
