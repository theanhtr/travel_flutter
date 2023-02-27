import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/constants/textstyle_constants.dart';

class OutButtonWidget extends StatelessWidget {
  const OutButtonWidget({super.key, required this.title, this.ontap});

  final String title;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          gradient: Gradients.outButtonGradientBackground,
        ),
        alignment: Alignment.center,
        child:
            Text(title, style: TextStyles.defaultStyle.bold.primaryTextColor),
      ),
    );
  }
}
