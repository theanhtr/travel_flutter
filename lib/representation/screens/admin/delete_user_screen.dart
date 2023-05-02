import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';

class DeleteUserAccount extends StatefulWidget {
  const DeleteUserAccount({super.key});
  static const String routename = '/sort_by_hotel_screen';

  @override
  State<DeleteUserAccount> createState() => _DeleteUserAccountState();
}

class _DeleteUserAccountState extends State<DeleteUserAccount> {
  bool isSelectedAll = true;
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(
        facility: "username (role)",
        icon: Icon(Icons.person_outlined),
        index: 0),
    _CheckBoxState(
        facility: "username (role)",
        icon: Icon(Icons.person_outlined),
        index: 1),
    _CheckBoxState(
        facility: "username (role)",
        icon: Icon(Icons.person_outlined),
        index: 2),
    _CheckBoxState(
        facility: "username (role)",
        icon: Icon(Icons.person_outlined),
        index: 3),
    _CheckBoxState(
        facility: "username (role)",
        icon: Icon(Icons.person_outlined),
        index: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: kMediumPadding * 4,
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
                            text: "Delete selected accounts",
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
            itemExtent: 100.0,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [...listCheckbox.map(buildItemCheckbox).toList()],
          ),
        ],
      ),
    );
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
