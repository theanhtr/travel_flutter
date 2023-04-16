import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/info_card.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';
import 'package:travel_app_ytb/representation/widgets/room_card_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout_screen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Container numberRounder(String number, bool selected) {
    return selected
        ? Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
                color: ColorPalette.backgroundColor,
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            child: Text(
              number,
              style: TextStyles.defaultStyle.primaryTextColor
                  .setTextSize(kDefaultTextSize / 2),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
                color: ColorPalette.noSelectbackgroundColor,
                borderRadius: BorderRadius.circular(kDefaultPadding)),
            child: Text(
              number,
              style: TextStyles.defaultStyle.whiteTextColor
                  .setTextSize(kDefaultTextSize / 2),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final Map<String, dynamic> roomSelect = args;

    return AppBarContainer(
      // ignore: sort_child_properties_last
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      numberRounder('1', true),
                      const SizedBox(
                        width: kDefaultPadding / 3,
                      ),
                      Text(
                        LocalizationText.bookAndReview,
                        style: TextStyles.defaultStyle.whiteTextColor
                            .setTextSize(kDefaultTextSize / 1.5),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding / 3,
                ),
                Container(
                  width: kDefaultPadding / 2,
                  child: const Divider(
                    color: ColorPalette.backgroundColor,
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding / 3,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      numberRounder('2', false),
                      const SizedBox(
                        width: kDefaultPadding / 3,
                      ),
                      Text(
                        LocalizationText.payment,
                        style: TextStyles.defaultStyle.whiteTextColor
                            .setTextSize(kDefaultTextSize / 1.5),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding / 3,
                ),
                Container(
                  width: kDefaultPadding / 2,
                  child: const Divider(
                    color: ColorPalette.backgroundColor,
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding / 3,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      numberRounder('3', false),
                      const SizedBox(
                        width: kDefaultPadding / 3,
                      ),
                      Text(
                        LocalizationText.confirm,
                        style: TextStyles.defaultStyle.whiteTextColor
                            .setTextSize(kDefaultTextSize / 1.5),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            RoomCardWidget(
              widthContainer: MediaQuery.of(context).size.width * 0.9,
              imageFilePath: roomSelect['imageFilePath'],
              name: roomSelect['name'],
              roomSize: roomSelect['roomSize'],
              services: roomSelect['services'],
              priceInfo: roomSelect['priceInfo'],
              roomCount: 1,
              ontap: () {
                Navigator.pushNamed(
                  context,
                  CheckoutScreen.routeName,
                );
              },
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoCard(
                    title: '${LocalizationText.signInAs}: ',
                    infoList: <String>[
                      'Name: Tran The Anh',
                      'SĐT: 0912945494',
                    ]),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  LocalizationText.contactIf,
                  style: TextStyles.defaultStyle.bold.blackTextColor
                      .setTextSize(kDefaultTextSize),
                ),
                const SizedBox(
                  height: kDefaultPadding / 2,
                ),
                Container(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    color: const Color.fromARGB(255, 231, 234, 244),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('* ',
                              style: TextStyles.defaultStyle.redTextColor
                                  .setTextSize(kDefaultTextSize * 1.2)),
                          Text(
                            LocalizationText.addContactInfor,
                            style: TextStyles.defaultStyle.blackTextColor
                                .setTextSize(kDefaultTextSize / 1.2),
                          ),
                        ],
                      ),
                      const ItemText(
                          icon: FontAwesomeIcons.plus,
                          sizeItem: kDefaultIconSize / 1.2,
                          primaryColor: ColorPalette.primaryColor,
                          secondaryColor: ColorPalette.noSelectbackgroundColor),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ButtonWidget(title: LocalizationText.Next, ontap: () {}),
            const SizedBox(
              height: kDefaultPadding,
            ),
          ],
        ),
      ),
      implementLeading: true,
      titleString: LocalizationText.checkout,
    );
  }
}
