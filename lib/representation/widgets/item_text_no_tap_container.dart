import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';

class ItemTextNoTap extends StatelessWidget {
  const ItemTextNoTap({
    super.key,
    required this.icon,
    this.text = '',
    required this.sizeItem,
    this.sizeText = 0,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final IconData icon;
  final String text;
  final double sizeItem;
  final double sizeText;
  final Color primaryColor;
  final Color secondaryColor;
  @override
  Widget build(BuildContext context) {
    return Column(
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
            style: TextStyles.defaultStyle.blackTextColor.setTextSize(sizeText))
      ],
    );
  }
}
