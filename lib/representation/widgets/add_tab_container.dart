import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_no_tap_container.dart';

class AddTabContainer extends StatefulWidget {
  const AddTabContainer({
    super.key,
    required this.icon,
    required this.content,
    required this.sizeItem,
    required this.sizeText,
    required this.primaryColor,
    required this.secondaryColor,
    required this.count,
    required this.onCountChanged,
  });

  final IconData icon;
  final String content;
  final double sizeItem;
  final double sizeText;
  final Color primaryColor;
  final Color secondaryColor;
  final int count;
  final Function(int) onCountChanged;

  @override
  State<AddTabContainer> createState() => _AddTabContainerState();
}

class _AddTabContainerState extends State<AddTabContainer> {
  int countCopy = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countCopy = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: const BoxDecoration(
        color: ColorPalette.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(kItemPadding)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ItemText(
                  icon: widget.icon,
                  sizeItem: widget.sizeItem,
                  primaryColor: widget.primaryColor,
                  secondaryColor: widget.secondaryColor,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.content,
                  style: TextStyles.defaultStyle.blackTextColor
                      .setTextSize(widget.sizeText),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (countCopy > 1)
                  GestureDetector(
                    onTap: () {
                      countCopy--;
                      widget.onCountChanged(countCopy);
                    },
                    child: ItemTextNoTap(
                      icon: FontAwesomeIcons.minus,
                      sizeItem: widget.sizeItem / 2,
                      primaryColor: Colors.white,
                      secondaryColor: const Color(0xFF3EC8BC).withOpacity(0.9),
                    ),
                  )
                else
                  ItemTextNoTap(
                    icon: FontAwesomeIcons.minus,
                    sizeItem: widget.sizeItem / 2,
                    primaryColor: Colors.white.withOpacity(0.5),
                    secondaryColor: const Color(0xFF3EC8BC).withOpacity(0.1),
                  ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding / 1.2),
                  child: Text(
                    countCopy.toString(),
                    style: TextStyles.defaultStyle.blackTextColor
                        .setTextSize(widget.sizeText),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    countCopy++;
                    widget.onCountChanged(countCopy);
                  },
                  child: ItemTextNoTap(
                    icon: FontAwesomeIcons.plus,
                    sizeItem: widget.sizeItem / 2,
                    primaryColor: Colors.white,
                    secondaryColor: const Color(0xFF3EC8BC).withOpacity(0.9),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
