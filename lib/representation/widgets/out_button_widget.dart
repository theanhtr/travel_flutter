import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';

import '../../core/constants/color_palatte.dart';
import '../../core/constants/textstyle_constants.dart';

class OutButtonWidget extends StatelessWidget {
  const OutButtonWidget({super.key, required this.title, this.ontap, this.backgroundColor});

  final String title;
  final Color? backgroundColor;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          gradient: backgroundColor != null ? null : Gradients.outButtonGradientBackground,
          color: backgroundColor,
        ),
        alignment: Alignment.center,
        child:
            Text(title, style: TextStyles.defaultStyle.bold.copyWith(
                color: backgroundColor != null ? Colors.white : ColorPalette.primaryColor,
            )),
      ),
    );
  }
}
