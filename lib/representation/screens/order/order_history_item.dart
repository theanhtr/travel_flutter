import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/date_helper.dart';
import 'package:travel_app_ytb/representation/widgets/animation/alarm_animation.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';

import '../../../core/constants/dismention_constants.dart';
import '../../../core/constants/textstyle_constants.dart';
import '../../../helpers/asset_helper.dart';
import '../../../helpers/image_helper.dart';
import '../../../helpers/translations/localization_text.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({
    super.key,
    required this.widthContainer,
    required this.name,
    required this.roomSize,
    required this.priceInfo,
    this.roomCount = 0,
    this.numberOfBed = 0,
    required this.checkInDate,
    required this.checkOutDate,
    required this.typeRoomName,
    required this.totalPrice,
    required this.onTap,
    required this.reviewed,
    required this.orderStatusName,
    required this.orderStatusId,
  });

  final double widthContainer;
  final String name;
  final String typeRoomName;
  final int roomSize;
  final double priceInfo;
  final int roomCount;
  final int numberOfBed;
  final String checkInDate;
  final String checkOutDate;
  final double totalPrice;
  final Function() onTap;
  final bool reviewed;
  final String orderStatusName;
  final int orderStatusId;

  int calculateNights() {
    String startDate = DateHelper().convertDateString(
        dateString: checkInDate,
        inputFormat: "MM/dd/yyyy",
        outputFormat: 'dd MMM yyyy');
    String endDate = DateHelper().convertDateString(
        dateString: checkOutDate,
        inputFormat: "MM/dd/yyyy",
        outputFormat: 'dd MMM yyyy');
    DateHelper dateHelper = DateHelper();
    dateHelper.convertSelectDateOnHotelBookingScreenToDateTime(
        "$startDate - $endDate");
    debugPrint(
        "40 ${dateHelper.endDate?.difference(dateHelper.startDate ?? DateTime.now()).inDays}");
    return (dateHelper.endDate
                ?.difference(dateHelper.startDate ?? DateTime.now())
                .inDays ??
            0) +
        1;
  }

  @override
  Widget build(BuildContext context) {
    int countNight = calculateNights();
    return TapableWidget(
      onTap: onTap,
      child: Container(
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
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6,
                    ),
                    child: Text(
                      name,
                      style: TextStyles.defaultStyle.bold.blackTextColor
                          .setTextSize(kDefaultTextSize * 1.2),
                    ),
                  ),
                  Text(
                    typeRoomName,
                    style: TextStyles.defaultStyle.bold.blackTextColor
                        .setTextSize(kDefaultTextSize),
                  ),
                  const SizedBox(
                    height: kItemPadding,
                  ),
                  Text(
                    'Room Size: $roomSize m2',
                    style: TextStyles.defaultStyle.light.blackTextColor
                        .setTextSize(kDefaultTextSize / 1.2),
                  ),
                  Row(
                    children: [
                      ImageHelper.loadFromAsset(
                        AssetHelper.bedIcon,
                        width: 20,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        numberOfBed <= 1
                            ? '$numberOfBed ${LocalizationText.bedRoom}'
                            : '$numberOfBed ${LocalizationText.bedsRoom}',
                        style: TextStyles.defaultStyle.light.blackTextColor
                            .setTextSize(kDefaultTextSize),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              AlarmAnimation(
                size: 60,
                animated: reviewed == reviewed && orderStatusId == 8,
              )
            ],
          ),
          const SizedBox(
            height: kDefaultPadding,
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
                child: Row(
                  children: [
                    ImageHelper.loadFromAsset(
                      AssetHelper.checkInIcon,
                      height: 32,
                      width: 32,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text(
                          "Check-in",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 12,
                            color: const Color.fromRGBO(99, 99, 99, 1),
                          ),
                        ),
                        Text(
                          checkInDate,
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(49, 49, 49, 1),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    ImageHelper.loadFromAsset(
                      AssetHelper.checkOutIcon,
                      height: 32,
                      width: 32,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text(
                          "Check-out",
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 12,
                            color: const Color.fromRGBO(99, 99, 99, 1),
                          ),
                        ),
                        Text(
                          checkOutDate,
                          style: TextStyles.defaultStyle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(49, 49, 49, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(kDefaultPadding),
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultPadding),
              color: const Color.fromARGB(255, 231, 234, 244),
            ),
            child: Column(children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        countNight <= 1
                            ? "$countNight night"
                            : "$countNight nights",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        // TODO remove fake data
                        "$roomCount rooms",
                        style: TextStyles.defaultStyle.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      "Total:",
                      textAlign: TextAlign.end,
                      style: TextStyles.defaultStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    // TODO remove fake data
                    "\$$totalPrice",
                    style: TextStyles.defaultStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
