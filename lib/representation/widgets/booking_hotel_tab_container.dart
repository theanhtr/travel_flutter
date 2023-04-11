import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';

import '../../helpers/image_helper.dart';

class BookingHotelTab extends StatefulWidget {
  const BookingHotelTab({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.sizeItem,
    required this.sizeText,
    required this.primaryColor,
    required this.secondaryColor,
    required this.iconString,
    this.implementSetting = false,
    this.useIconString,
    this.bordered,
    this.ontap,
  });

  final String? useIconString;
  final String? bordered;
  final IconData icon;
  final String iconString;
  final String title;
  final String description;
  final double sizeItem;
  final double sizeText;
  final Color primaryColor;
  final Color secondaryColor;
  final bool implementSetting;
  final Function()? ontap;

  @override
  State<BookingHotelTab> createState() => _BookingHotelTabState();
}

class _BookingHotelTabState extends State<BookingHotelTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(kItemPadding)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: widget.useIconString != null
                  ? widget.bordered == null
                      ? SizedBox(
                          height: widget.sizeItem * 3,
                          child: ImageHelper.loadFromAsset(widget.iconString),
                        )
                      : Container(
                          padding: EdgeInsets.all(widget.sizeItem),
                          margin: const EdgeInsets.all(kDefaultPadding),
                          decoration: BoxDecoration(
                              color: const Color(0xffFE9C5E).withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding)),
                          child:
                              ImageHelper.loadFromAsset(widget.iconString),
                        )
                  : ItemText(
                      icon: widget.icon,
                      sizeItem: widget.sizeItem,
                      primaryColor: widget.primaryColor,
                      secondaryColor: widget.secondaryColor,
                      ontap: widget.ontap,
                    ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(top: kMediumPadding / 5),
                      child: Text(
                        widget.title,
                        style: TextStyles.defaultStyle.blackTextColor
                            .setTextSize(widget.sizeText),
                      ),
                    ),
                  ),
                  widget.description != ""
                      ? Container(
                          margin: const EdgeInsets.only(
                              top: kMediumPadding / 10,
                              bottom: kMediumPadding / 4),
                          child: Text(
                            widget.description,
                            style: TextStyles.defaultStyle.blackTextColor.bold
                                .setTextSize(widget.sizeText),
                          ),
                        )
                      : SizedBox(width: 0, height: 0),
                ],
              ),
            ),
            if (widget.implementSetting)
              Expanded(
                flex: 2,
                child: ItemText(
                  icon: FontAwesomeIcons.gear,
                  sizeItem: widget.sizeItem / 2,
                  primaryColor: Color(0xFF323B4B).withOpacity(0.9),
                  secondaryColor: Color(0xFF323B4B).withOpacity(0.1),
                  ontap: widget.ontap,
                ),
              )
            else
              Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}
