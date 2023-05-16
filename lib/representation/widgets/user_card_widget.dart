import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/adminManager/admin_manager.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/dropdown_button_widget.dart';

import '../../helpers/translations/localization_text.dart';

class UserCardWidget extends StatefulWidget {
  int? id;
  String? email;
  Function callback;
  UserCardWidget(
      {super.key,
      required this.widthContainer,
      required this.email,
      required this.id,
      required this.callback});
  final double widthContainer;

  @override
  State<UserCardWidget> createState() => _UserCardWidgetState();
}

class _UserCardWidgetState extends State<UserCardWidget> {
  int? idRoleNameChange;

  AdminManager _controller = AdminManager();

  @override
  Widget build(BuildContext context) {
    print("value role change: $idRoleNameChange ");
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kDefaultPadding / 2.5),
          width: widget.widthContainer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding),
            color: const Color.fromARGB(255, 231, 234, 244),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.email.toString(),
                      style: TextStyles.defaultStyle.bold.blackTextColor
                          .setTextSize(kDefaultTextSize * 1.4),
                    ),
                    const SizedBox(
                      height: kItemPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(right: kDefaultPadding / 6),
                          child: const Icon(
                            FontAwesomeIcons.locationDot,
                            color: Color(0xFFF77777),
                            size: kDefaultIconSize / 1.2,
                          ),
                        ),
                        Text(
                          _controller.checkRole(widget.id),
                          style: TextStyles.defaultStyle.blackTextColor.medium
                              .setTextSize(kDefaultTextSize / 1.4),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kItemPadding,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 123, 22, 22),
                    ),
                    const SizedBox(
                      height: kItemPadding,
                    ),
                    Row(
                      children: [
                        ButtonWidget(
                          title: LocalizationText.deleteUser,
                          ontap: () async {
                            await _controller
                                .deleteUser(widget.email.toString())
                                .then((value) => {
                                      if (value['success'] == true)
                                        {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.topSlide,
                                            title: LocalizationText
                                                .deleteUserSuccess,
                                            desc: LocalizationText.ok,
                                            btnOkOnPress: () {
                                              widget.callback();
                                            },
                                          ).show()
                                        }
                                      else
                                        {
                                          // Loading.dismiss(context),
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.error,
                                            animType: AnimType.topSlide,
                                            title: LocalizationText
                                                .errorWhenCallApi,
                                            desc: value['message'],
                                            btnOkOnPress: () {},
                                          ).show()
                                        },
                                    });
                          },
                        ),
                        ButtonWidget(
                          title: LocalizationText.changeRole,
                          ontap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(LocalizationText.selectRole),
                              content: DropdownButtonCustom(
                                onchange: (value) {
                                  idRoleNameChange = value;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: TextButton(
                                      onPressed: () async {
                                        await _controller
                                            .changeRole(widget.email.toString(),
                                                idRoleNameChange)
                                            .then((value) => {
                                                  if (value['success'] == true)
                                                    {
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.success,
                                                        animType:
                                                            AnimType.topSlide,
                                                        title: LocalizationText
                                                            .checkAll,
                                                        desc: LocalizationText
                                                            .changeRoleSuccess,
                                                        btnOkOnPress: () {
                                                          widget.callback();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ).show()
                                                    }
                                                  else
                                                    {
                                                      // Loading.dismiss(context),
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.error,
                                                        animType:
                                                            AnimType.topSlide,
                                                        title: LocalizationText
                                                            .checkAll,
                                                        desc: value['message'],
                                                        btnOkOnPress: () {},
                                                      ).show()
                                                    },
                                                });
                                      },
                                      child: Text(LocalizationText.changeRole)),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ]),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

// class DropdownButtonCustom extends StatefulWidget {
//   DropdownButtonCustom({super.key, required this.onchange});
//   Function onchange;
//   @override
//   State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
// }

// class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
//   String? _selectedLocation;
//   AdminManager _controller = AdminManager();

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       value: _selectedLocation,
//       dropdownColor: ColorPalette.noSelectbackgroundColor,
//       items: <String>[
//         LocalizationText.admin,
//         LocalizationText.user,
//         LocalizationText.hotelManagement,
//         LocalizationText.airlineManager
//       ].map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         print(newValue);
//         widget.onchange(_controller.checkRoleString(newValue));

//         setState(() {
//           _selectedLocation = newValue;
//         });
//       },
//     );
//   }
// }
