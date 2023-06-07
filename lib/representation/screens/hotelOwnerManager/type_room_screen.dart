import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/core/utils/navigation_utils.dart';
import 'package:travel_app_ytb/helpers/date_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/models/room_model.dart';
import 'package:travel_app_ytb/representation/screens/checkout/checkout_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/add_type_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/type_room_controller.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/update_type_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/room_booking/select_room_controller.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/room_card_widget.dart';
import 'package:travel_app_ytb/representation/widgets/type_room_card_widget.dart';

import '../../../core/constants/dismention_constants.dart';
import '../../widgets/loading/loading.dart';
import 'add_rooms_screen.dart';
import 'change_image_screen.dart';

class TypeRoomScreen extends StatefulWidget {
  const TypeRoomScreen({super.key});

  static const String routeName = '/type_room_screen';

  @override
  State<TypeRoomScreen> createState() => _TypeRoomScreenState();
}

class _TypeRoomScreenState extends State<TypeRoomScreen> {
  // List<RoomModel> listRooms = [
  //   RoomModel(
  //     name: "vip",
  //     size: 21,
  //     services: ['Free wifi'],
  //     price: 10,
  //     countAvailabilityRoom: 5,
  //   )
  // ];
  List<RoomModel> listRooms = [];

  TypeRoomController? _controller;
  bool _isLoaded = false;

  void _initData() {
    if (_isLoaded == false) {
      _controller?.getAllTypeRoom().then((value) => {
            _isLoaded = true,
            setState(() {
              listRooms = value;
            }),
          });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TypeRoomController();
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return _isLoaded == false
        ? const SpinKitCircle(
            color: Colors.black,
            size: 64.0,
          )
        : listRooms.isNotEmpty == true
            ? SingleChildScrollView(
                child: Column(
                  children: List.generate(listRooms.length, (index) {
                    return Column(
                      children: [
                        TypeRoomCardWidget(
                          id: listRooms[index].id ?? -1,
                          widthContainer:
                              MediaQuery.of(context).size.width * 0.9,
                          imageFilePath: listRooms[index].imagePath ??
                              ConstUtils.imgHotelDefault,
                          name: listRooms[index].name ?? "vip",
                          roomSize: listRooms[index].size ?? 21,
                          services: listRooms[index].services ?? [],
                          priceInfo: listRooms[index].price ?? 10,
                          roomCount: listRooms[index].occupancy ?? 0,
                          roomQuantity:
                              listRooms[index].countAvailabilityRoom ?? 0,
                          numberOfBed: listRooms[index].numberOfBeds ?? 0,
                          ontap: () async {
                            await Navigator.pushNamed(
                              context,
                              UpdateTypeRoomScreen.routeName,
                              arguments: {
                                "room_selected": listRooms[index],
                              },
                            );
                            _isLoaded = false;
                            setState(() {});
                          },
                          addFunction: () async {
                            await Navigator.pushNamed(
                              context,
                              AddRoomsScreen.routeName,
                              arguments: {
                                "type_room_id": "${listRooms[index].id}",
                              },
                            );
                            _isLoaded = false;
                            setState(() {});
                          },
                          changeImageFunction: () async {
                            await Navigator.pushNamed(
                              context,
                              ChangeImageScreen.routeName,
                              arguments: {
                                "type_room_id": "${listRooms[index].id}",
                                "image_id": listRooms[index].imageId ?? -1,
                                "image_path": listRooms[index].imagePath,
                              },
                            );
                            _isLoaded = false;
                            setState(() {});
                          },
                          deleteFunction: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.topSlide,
                              title:
                                  "Bạn có chắc chắn muốn xóa loại phòng này?",
                              btnOkOnPress: () {
                                Loading.show(context);
                                _controller
                                    ?.deleteTypeRoom(listRooms[index].id ?? -1)
                                    .then((value) => {
                                          Loading.dismiss(context),
                                          if (value == true)
                                            {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.success,
                                                animType: AnimType.topSlide,
                                                title: LocalizationText.success,
                                                btnOkOnPress: () {
                                                  _isLoaded = false;
                                                  setState(() {});
                                                },
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
                              btnCancelOnPress: () {},
                            ).show();
                          },
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 2,
                        ),
                      ],
                    );
                  }),
                ),
              )
            : Center(
                child: Text(
                  LocalizationText.roomHotelListIsEmpty,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              );
  }
}
