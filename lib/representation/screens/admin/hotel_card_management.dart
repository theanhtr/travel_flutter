import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class HotelListManagement extends StatelessWidget {
  const HotelListManagement({
    super.key,
    required this.widthContainer,
    required this.name,
    required this.starInfo,
    required this.priceInfoLow,
    required this.priceInfohigh,
    required this.ontap,
    required this.createAt,
    required this.id,
    this.description,
  });

  final double widthContainer;

  final String name;
  final double starInfo;
  final String priceInfoLow;
  final String priceInfohigh;
  final String createAt;
  final String? description;
  final Function() ontap;
  final int id;
  String getFormatedDate(_date) {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: kDefaultPadding / 5),
                            child: const Icon(
                              FontAwesomeIcons.solidCalendar,
                              color: Color.fromARGB(255, 182, 49, 129),
                              size: kDefaultIconSize / 1.2,
                            ),
                          ),
                          Text(
                            getFormatedDate(createAt),
                            style: TextStyles.defaultStyle.bold.blackTextColor
                                .setTextSize(kDefaultTextSize / 1.2),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kItemPadding,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Container(
                      //       margin: const EdgeInsets.only(
                      //           right: kDefaultPadding / 6),
                      //       child: const Icon(
                      //         FontAwesomeIcons.locationDot,
                      //         color: Color(0xFFF77777),
                      //         size: kDefaultIconSize / 1.2,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: kItemPadding,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: kDefaultPadding / 5),
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
                            '\$ $priceInfoLow - $priceInfohigh',
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
                      const SizedBox(
                        height: kItemPadding,
                      ),
                      ButtonWidget(
                        title: 'Delete hotel',
                        ontap: ontap,
                      ),
                    ],
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
