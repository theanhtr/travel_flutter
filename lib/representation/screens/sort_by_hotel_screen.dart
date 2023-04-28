import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';
import '../../helpers/asset_helper.dart';

class SortByHotel extends StatefulWidget {
  const SortByHotel({super.key});
  static const String routeName = '/sort_by_hotel_screen';

  @override
  State<SortByHotel> createState() => _SortByHotelState();
}

class _SortByHotelState extends State<SortByHotel> {
  bool isSelectedAll = true;
  int sortById = 1;
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(
      facility: LocalizationText.lowestPrice,
      icon: Container(),
      index: 1,
    ),
    _CheckBoxState(
        facility: LocalizationText.highestPrice, icon: Container(), index: 2),
    _CheckBoxState(
        facility: LocalizationText.highestRating, icon: Container(), index: 3),
    _CheckBoxState(
        facility: LocalizationText.nearestDistance,
        icon: Container(),
        index: 4),
  ];
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    String selected = "";
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (isFirst) {
      isFirst = false;
      sortById = args['oldSortById'];
      listCheckbox[args['oldSortById'] - 1].checkBoxValue = true;
    }

    return AppBarContainer(
        implementLeading: true,
        titleString: LocalizationText.sortBy,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: kMediumPadding * 3,
              ),

              // ListView(
              //   itemExtent: 84.0,
              //   shrinkWrap: true,
              //   physics: const ScrollPhysics(),
              //   children: [...listCheckbox.map(buildItemCheckbox).toList()],

              // ),
              Column(children: [
                Column(
                  children: List.generate(
                    listCheckbox.length,
                    (index) => CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(
                        listCheckbox[index].facility,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                      value: listCheckbox[index].checkBoxValue,
                      onChanged: (value) {
                        setState(() {
                          for (var element in listCheckbox) {
                            element.checkBoxValue = false;
                          }
                          listCheckbox[index].checkBoxValue = value ?? false;
                          selected =
                              "${listCheckbox[index].facility}, ${listCheckbox[index].index}, ${listCheckbox[index].checkBoxValue}";
                          sortById = index + 1;
                        });
                      },
                    ),
                  ),
                )
              ]),
              Container(
                margin: const EdgeInsets.only(top: kDefaultPadding),
                child: ButtonWidget(
                  title: LocalizationText.apply,
                  ontap: () {
                    args['getData'](sortById);
                    Navigator.pop(context);
                  },
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
