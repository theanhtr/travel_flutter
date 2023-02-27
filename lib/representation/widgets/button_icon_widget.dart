import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/constants/textstyle_constants.dart';

class ButtonIconWidget extends StatelessWidget {
  const ButtonIconWidget(
      {super.key,
      required this.title,
      this.ontap,
      required this.backgroundColor,
      required this.textColor,
      required this.icon});

  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Widget icon;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          color: backgroundColor,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: kDefaultPadding / 2,
            ),
            Text(
              title,
              style: TextStyles.defaultStyle.bold
                  .setColor(textColor)
                  .setTextSize(kDefaultTextSize),
            ),
          ],
        ),
      ),
    );
  }
}
