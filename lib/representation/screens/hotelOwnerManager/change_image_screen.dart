// ignore_for_file: use_build_context_synchronously

import 'dart:io';

// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/core/utils/navigation_utils.dart';
import 'package:travel_app_ytb/core/utils/user_preferences.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/user_controller.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/upload_image_screen.dart';
import 'package:travel_app_ytb/representation/screens/user_fill_in_information_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'package:travel_app_ytb/representation/widgets/profile_widget.dart';
import 'package:travel_app_ytb/representation/widgets/textfield_widget.dart';

// import 'package:user_profile_ii_example/model/user.dart';
// import 'package:user_profile_ii_example/utils/user_preferences.dart';
// import 'package:user_profile_ii_example/widget/appbar_widget.dart';
// import 'package:user_profile_ii_example/widget/button_widget.dart';
// import 'package:user_profile_ii_example/widget/profile_widget.dart';
// import 'package:user_profile_ii_example/widget/textfield_widget.dart';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';

import 'change_image_controller.dart';

class ChangeImageScreen extends StatefulWidget {
  const ChangeImageScreen({super.key});

  static const routeName = '/edit_profile_screen';
  @override
  _ChangeImageScreenState createState() => _ChangeImageScreenState();
}

class _ChangeImageScreenState extends State<ChangeImageScreen> {
  UserModel user = UserPreferences.myUser;
  ChangeImageController? _controller;
  bool check = false;
  String image = "";
  XFile? imageFileUpdate;
  BaseClient a = BaseClient(LocalStorageHelper.getValue("userToken"));
  String typeRoomId = "-1";
  int imageId = -1;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = NavigationUtils.getArguments(context);
    typeRoomId = args['type_room_id'];
    imageId = args['image_id'];

    _controller = ChangeImageController();
    if (check == false) {
      image = "";
      setState(() {
        check = true;
      });
    }
    // debugPrint('${check}: check value');
    return AppBarContainer(
      titleString: LocalizationText.changeImage,
      implementLeading: true,
      child: Container(
        padding: EdgeInsets.only(top: kDefaultIconSize * 3.3),
        child: Builder(
          builder: (context) => Scaffold(
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: kMediumPadding * 7.5,
                  child: UploadIamge(
                    isEdit: imageFileUpdate != null ? true : false,
                    imagePath: imageFileUpdate?.path ??
                        args['image_path'] ??
                        ConstUtils.imgHotelDefault,
                    onchange: (XFile file) => {
                      setState(
                        () {
                          imageFileUpdate = file;
                        },
                      )
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.only(top: kDefaultPadding),
                  child: ButtonWidget(
                    title: LocalizationText.update,
                    ontap: () async {
                      if (imageFileUpdate != null) {
                        Loading.show(context);
                        bool err = true;
                        if (imageId != -1) {
                          await _controller
                              ?.deleteTypeRoomImage(typeRoomId, imageId)
                              .then((value) => {
                                    if (value == true)
                                      {
                                        err = false,
                                      }
                                    else
                                      {
                                        Loading.dismiss(context),
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.warning,
                                          animType: AnimType.topSlide,
                                          title: LocalizationText.err,
                                          btnOkOnPress: () {},
                                        ).show(),
                                      },
                                  });
                        } else {
                          err = false;
                        }
                        if (!err) {
                          print("OOOOOOOOO");
                          try {
                            Dio dioRequest;
                            String? token;

                            ///[1] CREATING INSTANCE
                            dioRequest = dio.Dio();
                            // dioRequest.options.baseUrl = baseUrl;
                            //[2] ADDING TOKEN
                            token =
                                await LocalStorageHelper.getValue("userToken")
                                    as String?;

                            dioRequest.options.headers = {
                              'Authorization': 'Bearer ${token}',
                              'Accept': 'application/json',
                              'Content-type': 'application/json'
                            };
                            var formData = dio.FormData.fromMap({
                              'first_name': '',
                            });
                            //[4] ADD IMAGE TO UPLOAD
                            // debugPrint('${formData.('last_name')}: lastname value');
                            if (imageFileUpdate != null) {
                              var file = await dio.MultipartFile.fromFile(
                                  imageFileUpdate!.path,
                                  filename: basename(imageFileUpdate!.path),
                                  contentType: MediaType("image",
                                      basename(imageFileUpdate!.path)));

                              formData.files.add(MapEntry('images[]', file));
                            }

                            //[5] SEND TO SERVER
                            var response = await dioRequest.post(
                              "${a.baseUrlForImport}/my-hotel/type-rooms/$typeRoomId/images",
                              data: formData,
                            );
                            Loading.dismiss(context);
                            if (response != null) {
                              debugPrint(
                                  "succeess update response: ${response.data}");
                              if (response.data['success'] == true) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.editProfileSuccess,
                                  desc: response.data['message'],
                                  btnOkOnPress: () {
                                    // if (LocalStorageHelper.getValue("roleId") ==
                                    //     1) {
                                    //   setState(() {});
                                    // } else {
                                    //   Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const MainScreen(
                                    //               currentIndex: 3,
                                    //             )),
                                    //     (Route<dynamic> route) => false,
                                    //   );
                                    // }
                                  },
                                ).show();
                              } else if (response.data['success'] == false) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.errorWhenCallApi,
                                  desc: response.data['message'],
                                  btnOkOnPress: () {},
                                ).show();
                              }
                            }
                          } on DioError catch (e) {
                            // The request was made and the server responded with a status code
                            // that falls out of the range of 2xx and is also not 304.
                            print(
                                'response dong 191: ${e.type} ${e.response?.statusCode}');
                            if (e.response != null) {
                              if (e.response?.data['success'] == true) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.editProfileSuccess,
                                  desc: e.response?.data['message'],
                                  btnOkOnPress: () {
                                    // Navigator.popAndPushNamed(
                                    //     context, ProfilePage.routeName);
                                  },
                                ).show();
                              } else if (e.response?.data['success'] == false) {
                                if (e.type == DioErrorType.badResponse &&
                                    e.response?.statusCode == 400) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.topSlide,
                                    title:
                                        LocalizationText.haveToFillInforFirst,
                                    desc: e.response?.data['data'] != null
                                        ? ' ${e.response?.data['data']}'
                                        : ' ${e.response?.data['message'][0]}',
                                    btnOkOnPress: () {
                                      // Navigator.of(context).pushNamed(
                                      //     FillInforScreen.routeName,
                                      //     arguments: {
                                      //       "reloadProfile": () {
                                      //         setState(() {});
                                      //       }
                                      //     });
                                    },
                                  ).show();
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    animType: AnimType.topSlide,
                                    title: LocalizationText.errorWhenCallApi,
                                    desc: e.response?.data['data'] != null
                                        ? ' ${e.response?.data['data']}'
                                        : ' ${e.response?.data['message'][0]}',
                                    btnOkOnPress: () {
                                      // Navigator.pop(
                                      //     context, LocalizationText.cancel);
                                    },
                                  ).show();
                                }
                              }
                            } else {
                              // Something happened in setting up or sending the request that triggered an Error
                              print(e.requestOptions);
                              print(e.message.runtimeType);
                            }
                          }
                        }
                      } else {
                        AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.editProfileSuccess,
                                  btnOkOnPress: () {
                                    // if (LocalStorageHelper.getValue("roleId") ==
                                    //     1) {
                                    //   setState(() {});
                                    // } else {
                                    //   Navigator.pushAndRemoveUntil(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const MainScreen(
                                    //               currentIndex: 3,
                                    //             )),
                                    //     (Route<dynamic> route) => false,
                                    //   );
                                    // }
                                  },
                                ).show();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
