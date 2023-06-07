import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/login_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/update_type_room_controller.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_fill_in_information_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/line_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../../../core/utils/navigation_utils.dart';
import '../../models/room_model.dart';
import '../../widgets/booking_hotel_tab_container.dart';
import '../facility_hotel_screen.dart';
import 'add_rooms_controller.dart';
import 'add_type_room_controller.dart';

/*
...
...Đã làm chuyển ngữ
*/
class AddRoomsScreen extends StatefulWidget {
  const AddRoomsScreen({super.key});

  static const String routeName = '/add_rooms_screen';

  @override
  State<AddRoomsScreen> createState() => _AddRoomsScreenState();
}

class _AddRoomsScreenState extends State<AddRoomsScreen> {
  String quantity = "";
  String typeRoomId = "-1";
  AddRoomsController? _controller;

  @override
  Widget build(BuildContext context) {
    _controller = AddRoomsController();
    final Map<String, dynamic> args = NavigationUtils.getArguments(context);
    typeRoomId = args['type_room_id'];

    return AppBarContainer(
      titleString: LocalizationText.add,
      implementLeading: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.numberOfRooms,
                value: quantity,
                onchange: (String value) {
                  quantity = value;
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            ButtonWidget(
              title: LocalizationText.add,
              ontap: () {
                Loading.show(context);
                _controller
                    ?.addRooms(typeRoomId, quantity)
                    .then((value) => {
                          Loading.dismiss(context),
                          if (value == true)
                            {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.topSlide,
                                title: LocalizationText.success,
                                btnOkOnPress: () {},
                              ).show()
                            }
                          else
                            {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.topSlide,
                                title: LocalizationText.err,
                                btnOkOnPress: () {},
                              ).show(),
                            },
                        });
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
