import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';

class BookingHotelTab extends StatefulWidget {
  const BookingHotelTab(
      {super.key,
      required this.icon,
      required this.title,
      required this.description,
      required this.sizeItem,
      required this.sizeText,
      required this.primaryColor,
      required this.secondaryColor,
      this.implementSetting = false,
      this.ontap});

  final IconData icon;
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
          color: ColorPalette.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(kItemPadding)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ItemText(
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
                  Container(
                    margin: const EdgeInsets.only(top: kMediumPadding / 5),
                    child: Text(
                      widget.title,
                      style: TextStyles.defaultStyle.blackTextColor
                          .setTextSize(widget.sizeText),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: kMediumPadding / 10, bottom: kMediumPadding / 4),
                    child: Text(
                      widget.description,
                      style: TextStyles.defaultStyle.blackTextColor.bold
                          .setTextSize(widget.sizeText),
                    ),
                  ),
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
