import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/service_load_helper.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({
    super.key,
    required this.widthContainer,
    required this.imageFilePath,
    required this.name,
    required this.roomSize,
    required this.priceInfo,
    required this.services,
    required this.ontap,
    this.roomCount = 0,
  });

  final double widthContainer;
  final String imageFilePath;
  final String name;
  final int roomSize;
  final int priceInfo;
  final List<String> services;
  final int roomCount;

  final Function() ontap;

  @override
  Widget build(BuildContext context) {
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
                  'Room Size: $roomSize m2',
                  style: TextStyles.defaultStyle.light.blackTextColor
                      .setTextSize(kDefaultTextSize / 1.2),
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
                    '/night',
                    style: TextStyles.defaultStyle.medium.medium.blackTextColor
                        .setTextSize(kDefaultTextSize / 1.5),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: roomCount == 0
                  ? ButtonWidget(
                      title: 'Choose',
                      ontap: ontap,
                    )
                  : Text(
                      '$roomCount room',
                      style: TextStyles.defaultStyle.light.blackTextColor
                          .setTextSize(kDefaultTextSize),
                      textAlign: TextAlign.center,
                    ),
            )
          ],
        )
      ]),
    );
  }
}
