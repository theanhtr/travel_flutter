import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/helpers/adminManager/admin_manager.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/row_facility_hotel_detail.dart';
import 'dart:developer';

import 'package:travel_app_ytb/representation/widgets/user_card_widget.dart';

class ManageUser extends StatefulWidget {
  ManageUser({super.key, required this.usersList});
  static const String routename = '/sort_by_hotel_screen';
  List<dynamic> usersList;
  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  int count = 0;
  bool isFirst = true;
  bool _isLoading = false;
  bool _canLoadCardView = false;
  bool _loadHotelListDone = false;
  int isDone = 0;
  bool isSelectedAll = true;
  List<UserModel> listUserModel = [];
  List<dynamic> usersListDynamic = [];
  AdminManager _controller = AdminManager();
  String currentPosition = "";
  List<UserCardWidget> listUserCardWidget = [];
  @override
  void initState() {
    super.initState();
    _controller = AdminManager();
  }

  Future<void> _setCardList() async {
    listUserCardWidget = [];
    print('length dong 36 ${usersListDynamic.length} ');
    for (var element in listUserModel) {
      listUserCardWidget.add(UserCardWidget(
          widthContainer: MediaQuery.of(context).size.width * 0.9,
          email: element.email,
          id: element.id,
          callback: () {
            // _controller.getAllUser().then((value) => {

            // }),
            setState(() {
              isFirst = true;
              _isLoading = false;
              _loadHotelListDone = false;
              count = 0;
            });
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('KKKK $isFirst');
    // print("hotel dong 22: ${elementDetail}");

    if (isFirst) {
      // print('is loadnig $_isLoading');

      // print(
      //     'length dong 61 ${usersListDynamic.length} va is loadnig $_isLoading');
      if (!_isLoading && !_loadHotelListDone) {
        // print('dang chạy loading đâyyyyyy');
        _isLoading = true;
        listUserModel = [];
        // print('lengthfffffffffffff ${hotels}');
        UserModel user;
        _controller.getAllUser().then((value) => {
              usersListDynamic = _controller.getUserList,
              usersListDynamic.forEach((element) async {
                // print("hotel dong 22:  ${element["id"]}");

                // print("hotel dong 47 element detailllll: ${elementDetail}");

                // print('KKKK im here');
                count++;
                user =
                    UserModel(email: element["email"], id: element["role_id"]);
                listUserModel.add(user);
                if (count == usersListDynamic.length) {
                  setState(() {
                    _loadHotelListDone = true;
                  });
                }
              })
            });

        // print('length cua listhotel ${listUserModel.length} va count: $count');
      }
      // print(
      //     'length dong 87 ${usersListDynamic.length} va is loadnig $_isLoading');

      _canLoadCardView = true;
      if (_canLoadCardView == true && _loadHotelListDone && isDone != 1) {
        _canLoadCardView = false;
        listUserCardWidget = [];
        // print("hotel dong 76666666666666666666666666666: ${listHotel[0].id}");
        if (listUserModel.length > 0) {
          _setCardList().then((value) => {isDone = 1, setState(() {})});
        }
      }
    }

    if (isDone == 1) {
      isFirst = true;
      _isLoading = false;
      _canLoadCardView = false;
    }
    // return Row(
    //   children: (isDone-- > 0) ? [
    //     UserCardWidget(
    //       widthContainer: MediaQuery.of(context).size.width * 0.8,
    //     )
    //   ],
    // );
    return SingleChildScrollView(
      child: (isDone-- > 0)
          ? listUserCardWidget.isNotEmpty
              ? Column(
                  children: listUserCardWidget,
                )
              : Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: Center(
                    child: Text(
                      LocalizationText.noUser,
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
    );
  }
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

// class DropdownButtonCustom extends StatefulWidget {
//   const DropdownButtonCustom({super.key});

//   @override
//   State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
// }

// class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
//   String? _selectedLocation;
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       value: _selectedLocation,
//       dropdownColor: ColorPalette.noSelectbackgroundColor,
//       items: <String>['Admin', 'Customer', 'Hotel Manager', 'Airline Manager']
//           .map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         print(newValue);
//         setState(() {
//           _selectedLocation = newValue;
//         });
//       },
//     );
//   }
// }
