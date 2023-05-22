import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/adminManager/admin_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/dropdown_button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  String email = "";
  int? roleId;
  AdminManager _controller = AdminManager();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const SizedBox(
          height: kDefaultPadding,
        ),
        StatefulBuilder(
          builder: (context, setState) => InputCard(
            style: TypeInputCard.email,
            onchange: (String value) {
              email = value;
            },
            value: email,
          ),
        ),
        const SizedBox(
          height: kDefaultPadding * 2,
        ),
        Row(
          children: [
            Text(
              "${LocalizationText.selectRole}",
              style: TextStyles.defaultStyle.blackTextColor
                  .setTextSize(kDefaultTextSize),
            ),
          ],
        ),
        SizedBox(
          height: 80,
          child: Container(
            height: 25,
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color: ColorPalette.secondColor,
              border: Border.all(
                  color: ColorPalette.dividerColor, // Set border color
                  width: 3.0), // Set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // Set rounded corner radius
            ),
            child: Column(children: [
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,

              const SizedBox(
                width: kDefaultPadding * 2,
              ),

              DropdownButtonCustom(
                onchange: (int? value) {
                  roleId = value;
                },
              )
              // InputCard(
              //     style: TypeInputCard.roleId,
              //     onchange: (String value) {
              //       roleId = value;
              //     },
              //     value: roleId),
            ]),
          ),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        ButtonWidget(
          title: '${LocalizationText.createUser}',
          ontap: () async {
            if (email.isEmpty == true || roleId == null) {
              Loading.dismiss(context);
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: LocalizationText.missingInfor,
                desc: LocalizationText.haveToFillInforFirst,
                btnOkOnPress: () {},
              ).show();
            } else {
              Loading.show(context);
              await _controller
                  .createUser(email.toString(), roleId)
                  .then((value) => {
                        Loading.dismiss(context),
                        if (value.runtimeType != int)
                          {
                            if (value['success'] == true)
                              {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.createUserSuccess,
                                  desc: value['message'],
                                  btnOkOnPress: () {},
                                ).show()
                              }
                            else
                              {
                                Loading.dismiss(context),
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.checkAll,
                                  desc: value['message'],
                                  btnOkOnPress: () {},
                                ).show()
                              }
                          }
                      });
            }
          },
        ),
      ]),
    );
  }
}
