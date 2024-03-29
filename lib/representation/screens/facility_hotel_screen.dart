import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';

import '../../helpers/asset_helper.dart';

class FacilityHotel extends StatefulWidget {
  const FacilityHotel({super.key});
  static const String routeName = '/facility_hotel_screen';

  @override
  State<FacilityHotel> createState() => _FacilityHotelState();
}

class _FacilityHotelState extends State<FacilityHotel> {
  bool isSelectedAll = true;
  bool isFirst = true;
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(
      facility: LocalizationText.freeWifi,
      icon: ImageHelper.loadFromAsset(AssetHelper.wifiIcon,
          fit: BoxFit.contain, width: kDefaultPadding * 1.5),
      checkBoxValue: false,
      index: 1,
    ),
    _CheckBoxState(
      facility: LocalizationText.freeBreakfast,
      icon: ImageHelper.loadFromAsset(AssetHelper.freeBreakfast,
          fit: BoxFit.contain,
          width: kDefaultPadding * 1.5,
          tintColor: const Color.fromARGB(255, 97, 85, 204)),
      checkBoxValue: false,
      index: 2,
    ),
    _CheckBoxState(
      facility: LocalizationText.nonSmoking,
      icon: ImageHelper.loadFromAsset(AssetHelper.noSmoking,
          fit: BoxFit.contain,
          width: kDefaultPadding * 1.5,
          tintColor: const Color.fromARGB(255, 97, 85, 204)),
      checkBoxValue: false,
      index: 3,
    ),
    _CheckBoxState(
      facility: LocalizationText.nonRefunable,
      icon: ImageHelper.loadFromAsset(AssetHelper.nonRefundable,
          fit: BoxFit.contain,
          width: kDefaultPadding * 1.5,
          tintColor: const Color.fromARGB(255, 97, 85, 204)),
      checkBoxValue: false,
      index: 4,
    ),
    // _CheckBoxState(
    //     facility: "Currency Exchange",
    //     icon: ImageHelper.loadFromAsset(AssetHelper.currencyExchangeIcon,
    //         fit: BoxFit.contain, width: kDefaultPadding * 1.5),
    //     checkBoxValue: false,
    //     index: 4),
    _CheckBoxState(
        facility: LocalizationText.digitalTV,
        icon: ImageHelper.loadFromAsset(AssetHelper.digitalTv,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 5),
    _CheckBoxState(
        facility: LocalizationText.parkingArea,
        icon: ImageHelper.loadFromAsset(AssetHelper.parkingAreaIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 6),
    _CheckBoxState(
        facility: LocalizationText.swimmingPool,
        icon: ImageHelper.loadFromAsset(AssetHelper.swimingPoolIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 7),
    _CheckBoxState(
        facility: LocalizationText.carRental,
        icon: ImageHelper.loadFromAsset(AssetHelper.carRentalIcon,
            fit: BoxFit.contain, width: kDefaultPadding * 1.5),
        checkBoxValue: false,
        index: 8),
    // _CheckBoxState(
    //     facility: "Restaurant",
    //     icon: ImageHelper.loadFromAsset(AssetHelper.restaurantIcon,
    //         fit: BoxFit.contain, width: kDefaultPadding * 1.5),
    //     checkBoxValue: false,
    //     index: 9),
    // _CheckBoxState(
    //     facility: "24-hour Front Desk",
    //     icon: ImageHelper.loadFromAsset(AssetHelper.receptionIcon,
    //         fit: BoxFit.contain, width: kDefaultPadding * 1.5),
    //     checkBoxValue: false,
    //     index: 10),
  ];

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    if (isFirst) {
      isFirst = false;
      for (var i = 0; i < args['oldAmenities'].length; i++) {
        listCheckbox[args['oldAmenities'][i]].checkBoxValue = true;
      }
    }

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
                          int count = 0;
                          for (var i = 0; i < listCheckbox.length; i++) {
                            if (listCheckbox[i].checkBoxValue) {
                              count++;
                            }
                          }
                          if (count == listCheckbox.length) {
                            isSelectedAll = false;
                          } else {
                            isSelectedAll = true;
                          }
                          for (var i = 0; i < listCheckbox.length; i++) {
                            listCheckbox[i].checkBoxValue = isSelectedAll;
                          }
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
                ontap: () {
                  String amenities = "";
                  List<int> listCheckboxPosition = [];
                  for (var i = 0; i < listCheckbox.length; i++) {
                    if (listCheckbox[i].checkBoxValue == true) {
                      listCheckboxPosition.add(i);
                      if (amenities == "") {
                        amenities += '${listCheckbox[i].index}';
                      } else {
                        amenities += ',${listCheckbox[i].index}';
                      }
                    }
                  }
                  args['getData'](listCheckboxPosition, amenities);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(
              height: kMediumPadding,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemCheckbox(_CheckBoxState checkBoxSate) =>
      RowDetailFacilityHotel(
        facility: checkBoxSate.facility,
        icon: checkBoxSate.icon,
        checkBoxValue: checkBoxSate.checkBoxValue,
        index: checkBoxSate.index,
        getCheckBoxValue: (checkValue) {
          checkBoxSate.checkBoxValue = checkValue;
        },
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
