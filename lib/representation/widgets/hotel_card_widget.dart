import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class HotelCardWidget extends StatelessWidget {
  const HotelCardWidget({
    super.key,
    required this.widthContainer,
    required this.imageFilePath,
    required this.name,
    required this.locationInfo,
    required this.distanceInfo,
    required this.starInfo,
    required this.countReviews,
    required this.priceInfo,
    required this.ontap,
    this.description,
  });

  final double widthContainer;
  final String imageFilePath;
  final String name;
  final String locationInfo;
  final String distanceInfo;
  final double starInfo;
  final int countReviews;
  final String priceInfo;
  final String? description;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(kDefaultPadding / 2.5),
      width: widthContainer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: const Color.fromARGB(255, 231, 234, 244),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHelper.loadFromNetwork(
            imageFilePath,
            width: widthContainer,
            fit: BoxFit.fitWidth,
            radius: BorderRadius.circular(kDefaultPadding),
          ),
          Container(
              margin: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
                        locationInfo,
                        style: TextStyles.defaultStyle.blackTextColor.medium
                            .setTextSize(kDefaultTextSize / 1.4),
                      ),
                      Text(
                        ' -- $distanceInfo from destination',
                        style: TextStyles.defaultStyle.blackTextColor.light
                            .setTextSize(kDefaultTextSize / 2.0),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: kItemPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(right: kDefaultPadding / 5),
                        child: const Icon(
                          FontAwesomeIcons.solidStar,
                          color: Color(0xFFFFC107),
                          size: kDefaultIconSize / 1.2,
                        ),
                      ),
                      Text(
                        starInfo.toString(),
                        style: TextStyles.defaultStyle.blackTextColor.medium
                            .setTextSize(kDefaultTextSize / 1.2),
                      ),
                      Text(
                        ' ($countReviews reviews)',
                        style: TextStyles.defaultStyle.blackTextColor.light
                            .setTextSize(kDefaultTextSize / 1.2),
                      )
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
                      Text(
                        '\$ $priceInfo',
                        style: TextStyles.defaultStyle.bold.blackTextColor
                            .setTextSize(kDefaultTextSize * 1.6),
                      ),
                      Text(
                        '/night',
                        style: TextStyles
                            .defaultStyle.medium.medium.blackTextColor
                            .setTextSize(kDefaultTextSize / 1.5),
                      ),
                    ],
                  ),
                  ButtonWidget(
                    title: 'Book a room',
                    ontap: ontap,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
