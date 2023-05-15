import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/custom_checkbox_icon.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/tapable_widget.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({
    Key? key,
    this.addCardPress,
    this.nextTabPress,
    this.onChanged,
    this.isSelected = false,
    this.numberCard,
  }) : super(key: key);

  final Function()? addCardPress;
  final Function()? nextTabPress;
  final Function(bool?)? onChanged;
  final bool isSelected;
  final String? numberCard;

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          _AddNewCardItem(
            addCardPress: widget.addCardPress,
            onChanged: widget.onChanged,
            isSelected: widget.isSelected,
            numberCard: widget.numberCard,
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonWidget(
            title: LocalizationText.Next,
            ontap: widget.nextTabPress,
          ),
        ],
      ),
    );
  }
}

class _AddNewCardItem extends StatefulWidget {
  const _AddNewCardItem(
      {Key? key,
      this.addCardPress,
      this.onChanged,
      this.isSelected = false,
      this.numberCard})
      : super(key: key);
  final Function()? addCardPress;
  final Function(bool?)? onChanged;
  final bool isSelected;
  final String? numberCard;

  @override
  State<_AddNewCardItem> createState() => _AddNewCardItemState();
}

class _AddNewCardItemState extends State<_AddNewCardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
        color: Color.fromARGB(255, 231, 234, 244),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageHelper.loadFromAsset(
                  AssetHelper.cardPayIcon,
                  fit: BoxFit.fill,
                ),
                Text(
                  LocalizationText.creditDebitCard,
                  style: TextStyles.defaultStyle,
                ),
                CustomCheckboxIcon(
                  height: 24,
                  width: 24,
                  isChecked: widget.isSelected,
                  onChanged: widget.onChanged,
                  selected: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      color: ColorPalette.noSelectbackgroundColor,
                    ),
                  ),
                  unselected: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      color: const Color.fromRGBO(
                        143,
                        103,
                        232,
                        200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Card Number: ${widget.numberCard}"),
            const SizedBox(
              height: 10,
            ),
            TapableWidget(
              onTap: (widget.addCardPress),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.blue),
                child: const Text("Add Card"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
