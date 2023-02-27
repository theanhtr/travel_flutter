import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';

class ItemText extends StatelessWidget {
  const ItemText(
      {super.key,
      required this.icon,
      this.text = '',
      required this.sizeItem,
      this.sizeText = 0,
      required this.primaryColor,
      required this.secondaryColor,
      this.ontap});

  final IconData icon;
  final String text;
  final double sizeItem;
  final double sizeText;
  final Color primaryColor;
  final Color secondaryColor;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ?? () => {print('ontap in item_text')},
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(sizeItem),
            margin: text != ''
                ? const EdgeInsets.only(bottom: kDefaultPadding)
                : const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            child: Icon(
              icon,
              color: primaryColor,
              size: kDefaultIconSize,
            ),
          ),
          Text(text,
              softWrap: true,
              textAlign: TextAlign.center,
              style:
                  TextStyles.defaultStyle.blackTextColor.setTextSize(sizeText)),
        ],
      ),
    );
  }
}
