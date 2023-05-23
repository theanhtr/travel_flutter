import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/service_load_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/add_rooms_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/type_room_controller.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

import '../screens/Edit_profile_page.dart';
import '../screens/hotelOwnerManager/change_image_screen.dart';
import '../screens/upload_image_screen.dart';
import 'loading/loading.dart';

class TypeRoomCardWidget extends StatelessWidget {
  const TypeRoomCardWidget({
    super.key,
    required this.widthContainer,
    required this.imageFilePath,
    required this.name,
    required this.roomSize,
    required this.priceInfo,
    required this.services,
    required this.ontap,
    this.roomCount = 0,
    this.roomQuantity = 0,
    this.numberOfBed = 0,
    required this.id,
    required this.addFunction,
    required this.changeImageFunction,
    required this.deleteFunction,
  });

  final double widthContainer;
  final String imageFilePath;
  final String name;
  final int roomSize;
  final int priceInfo;
  final List<String> services;
  final int roomCount;
  final int roomQuantity;
  final int numberOfBed;
  final int id;

  final Function() ontap;
  final Function() addFunction;
  final Function() changeImageFunction;
  final Function() deleteFunction;

  @override
  Widget build(BuildContext context) {
    TypeRoomController _controller = TypeRoomController();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(kDefaultPadding),
      width: widthContainer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: const Color.fromARGB(255, 231, 234, 244),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.defaultStyle.bold.blackTextColor
                      .setTextSize(kDefaultTextSize * 1.2),
                ),
                const SizedBox(
                  height: kItemPadding,
                ),
                Text(
                  '${LocalizationText.roomSize}: $roomSize m2',
                  style: TextStyles.defaultStyle.light.blackTextColor
                      .setTextSize(kDefaultTextSize / 1.2),
                ),
                Text(
                  '${LocalizationText.maximum} $roomCount ${LocalizationText.peopleRoom}',
                  style: TextStyles.defaultStyle.light.blackTextColor
                      .setTextSize(kDefaultTextSize),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${LocalizationText.numberOfRooms}: $roomQuantity',
                  style: TextStyles.defaultStyle.light.blackTextColor
                      .setTextSize(kDefaultTextSize),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            ImageHelper.loadFromNetwork(
              imageFilePath,
              fit: BoxFit.contain,
              radius: BorderRadius.circular(kDefaultPadding),
              width: 60,
              height: 60,
            ),
          ],
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: List.generate(services.length, (index) {
            return ServiceLoadHelper.serviceWidget(services[index]);
          }),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        const Divider(
          color: Color.fromARGB(255, 123, 22, 22),
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$ $priceInfo',
                    style: TextStyles.defaultStyle.bold.blackTextColor
                        .setTextSize(kDefaultTextSize * 1.6),
                  ),
                  Text(
                    LocalizationText.night,
                    style: TextStyles.defaultStyle.medium.medium.blackTextColor
                        .setTextSize(kDefaultTextSize / 1.5),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: numberOfBed == 0
                  ? Container()
                  : Text(
                      numberOfBed <= 1
                          ? '$numberOfBed ${LocalizationText.bedRoom}'
                          : '$numberOfBed ${LocalizationText.bedsRoom}',
                      style: TextStyles.defaultStyle.light.blackTextColor
                          .setTextSize(kDefaultTextSize),
                      textAlign: TextAlign.center,
                    ),
            ),
          ],
        ),
        const SizedBox(
          height: kDefaultPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(
              title: LocalizationText.updateTypeRoom,
              ontap: ontap,
            ),
            const SizedBox(
              width: kMinPadding,
            ),
            ButtonWidget(
              title: LocalizationText.add,
              ontap: addFunction,
            ),
            const SizedBox(
              width: kMinPadding,
            ),
            ButtonWidget(
              title: LocalizationText.changeImage,
              ontap: changeImageFunction,
            ),
            const SizedBox(
              width: kMinPadding,
            ),
            ButtonWidget(
              title: LocalizationText.deleteTypeRoom,
              ontap: deleteFunction,
            ),
          ],
        ),
      ]),
    );
  }
}
