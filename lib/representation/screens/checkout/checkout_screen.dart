import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/core/utils/navigation_utils.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/representation/screens/checkout/payment_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/info_card.dart';
import 'package:travel_app_ytb/representation/widgets/item_text_container.dart';
import 'package:travel_app_ytb/representation/widgets/room_card_widget.dart';

import '../main_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout_screen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

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
    final Map<String, dynamic> args = NavigationUtils.getArguments(context);
    final RoomModel roomSelect = args['room_selected'];
    final String dateSelected = args['date_selected'];
    final int guestCount = args['guest_count'];
    final int roomCount = args['room_count'];

    return AppBarContainer(
      // ignore: sort_child_properties_last
      implementLeading: true,
      resizeToAvoidBottomInset: true,
      titleString: LocalizationText.checkout,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    numberRounder('1', false),
                    Text(
                      LocalizationText.bookAndReview,
                      style: TextStyles.defaultStyle.whiteTextColor
                          .setTextSize(kDefaultTextSize / 1.5),
                    )
                  ],
                ),
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
            ],
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.76901,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ListView(
                    children: [
                      RoomCardWidget(
                        widthContainer: MediaQuery.of(context).size.width * 0.9,
                        imageFilePath:
                            roomSelect.imagePath ?? ConstUtils.imgHotelDefault,
                        name: roomSelect.name ?? "",
                        roomSize: roomSelect.size ?? 21,
                        services: roomSelect.services ?? [],
                        priceInfo: roomSelect.price ?? 10,
                        roomCount: roomSelect.countAvailabilityRoom ?? 1,
                        numberOfBed: roomSelect.numberOfBeds ?? 0,
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
                                '${LocalizationText.name} ${LoginManager().userModel.name}',
                                '${LocalizationText.phoneNumber}: ${LoginManager().userModelProfile.phoneNumber}',
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
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding),
                              color: const Color.fromARGB(255, 231, 234, 244),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('* ',
                                        style: TextStyles
                                            .defaultStyle.redTextColor
                                            .setTextSize(
                                                kDefaultTextSize * 1.2)),
                                    Text(
                                      LocalizationText.addContactInfor,
                                      style: TextStyles
                                          .defaultStyle.blackTextColor
                                          .setTextSize(kDefaultTextSize / 1.2),
                                    ),
                                  ],
                                ),
                                const ItemText(
                                    icon: FontAwesomeIcons.plus,
                                    sizeItem: kDefaultIconSize / 1.2,
                                    primaryColor: ColorPalette.primaryColor,
                                    secondaryColor:
                                        ColorPalette.noSelectbackgroundColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      ButtonWidget(
                        title: LocalizationText.Next,
                        ontap: () {
                          _tabController.animateTo(1);
                        },
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                    ],
                  ),
                  PaymentScreen(
                    roomSelect: roomSelect,
                    dateSelected: dateSelected,
                    roomCount: roomCount,
                    isPaymentSuccess: (value) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.topSlide,
                        title: "congratulations",
                        desc: "Thank you for using our service",
                        btnOkOnPress: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const MainScreen(currentIndex: 0,)),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ).show();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _handleTabSelection() {
    // if (_tabController.index == 1) {
    //   _showBottomSheet();
    // }
  }
}
