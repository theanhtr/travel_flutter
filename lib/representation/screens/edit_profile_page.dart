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

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, this.reloadProfilePage});

  static const routeName = 'edit_profile_screen';
  late LoginManager log = LoginManager();
  Function? reloadProfilePage;
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserModel user = UserPreferences.myUser;
  String email = "";
  String firstName = "";
  String lastName = "";
  String phone_number = "";
  DateTime date_of_birth = DateTime.now();
  UserController? _controller;
  bool check = false;
  bool checkSelectDate = false;
  String image = "";
  XFile? imageFileUpdate;
  BaseClient a = BaseClient(LocalStorageHelper.getValue("userToken"));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1900, 8),
        initialDate: date_of_birth,
        lastDate: DateTime(2101));
    if (picked != null && picked != date_of_birth) {
      setState(() {
        date_of_birth = picked;
        checkSelectDate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.log = LoginManager();
    final Map<String, dynamic> argss =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _controller = UserController();
    debugPrint(
        '${widget.log.userModelProfile.dateOfBirth.toString()}: date of birth');
    if (check == false) {
      email = LoginManager().userModel.email ?? "lehuyhaianh0808@gmail.com";

      firstName = widget.log.userModelProfile.firstName.toString();
      lastName = widget.log.userModelProfile.lastName.toString();
      phone_number = widget.log.userModelProfile.phoneNumber.toString();
      date_of_birth = checkSelectDate == false
          ? (widget.log.userModelProfile.dateOfBirth == null
              ? DateTime.now()
              :
              // DateTime.parse(widget.log.userModelProfile.dateOfBirth.toString());
              DateTime.parse(
                  widget.log.userModelProfile.dateOfBirth.toString()))
          : (date_of_birth);

      image = widget.log.userModelProfile.photoUrl.toString();
      setState(() {
        check = true;
      });
    }
    // debugPrint('${check}: check value');
    return AppBarContainer(
      titleString: LocalizationText.updateUserInfor,
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
                        widget.log.userModelProfile.photoUrl.toString() ??
                        ConstUtils.defaultImageAvatar,
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
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.firstname,
                    text: firstName,
                    onChanged: (name) {
                      setState(() {
                        firstName = name;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.lastname,
                    text: lastName,
                    onChanged: (name) {
                      setState(() {
                        lastName = name;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.email,
                    text: email,
                    onChanged: (email) {
                      setState(() {
                        this.email = email;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.phoneNumber,
                    text: phone_number,
                    onChanged: (phone_numbe) {
                      setState(() {
                        phone_number = phone_numbe;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: StatefulBuilder(builder: (context, setState) {
                    return BookingHotelTab(
                      icon: FontAwesomeIcons.calendarDay,
                      title: LocalizationText.dateofbirth,
                      description:
                          widget.log.userModelProfile.dateOfBirth == null &&
                                  checkSelectDate == false
                              ? LocalizationText.dontHaveBirthDate
                              : "${date_of_birth.toLocal()}".split(' ')[0],
                      sizeItem: kDefaultIconSize,
                      sizeText: kDefaultIconSize / 1.2,
                      primaryColor: const Color(0xffF77777),
                      secondaryColor: const Color(0xffF77777).withOpacity(0.2),
                      implementSetting: true,
                      ontap: () => _selectDate(context),
                      //         child: Text(LocalizationText.selectDate),
                      iconString: '',
                    );
                  }),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.only(top: kDefaultPadding),
                  child: ButtonWidget(
                    title: LocalizationText.update,
                    ontap: () async {
                      {
                        Loading.show(context);
                        // debugPrint('${lastName}: lastname value');
                        UserModel userModel = UserModel();
                        userModel.email = email;
                        userModel.firstName = firstName;
                        userModel.lastName = lastName;
                        userModel.phoneNumber = phone_number;
                        userModel.dateOfBirth = date_of_birth.toString();
                        try {
                          ///[1] CREATING INSTANCE
                          var dioRequest = dio.Dio();
                          // dioRequest.options.baseUrl = baseUrl;
                          //[2] ADDING TOKEN
                          final token =
                              await LocalStorageHelper.getValue("userToken")
                                  as String?;

                          dioRequest.options.headers = {
                            'Authorization': 'Bearer ${token}',
                            'Accept': 'application/json',
                            'Content-type': 'application/json'
                          };
                          //[3] ADDING EXTRA INFO
                          debugPrint('${userModel.lastName}: lastnawe da');
                          var formData = dio.FormData.fromMap({
                            'first_name': '${userModel.firstName}',
                            'last_name': '${userModel.lastName}',
                            'date_of_birth': '${userModel.dateOfBirth}',
                            'phone_number': '${userModel.phoneNumber}',
                          });
                          //[4] ADD IMAGE TO UPLOAD
                          // debugPrint('${formData.('last_name')}: lastname value');
                          if (imageFileUpdate != null) {
                            var file = await dio.MultipartFile.fromFile(
                                imageFileUpdate!.path,
                                filename: basename(imageFileUpdate!.path),
                                contentType: MediaType(
                                    "image", basename(imageFileUpdate!.path)));

                            formData.files.add(MapEntry('image', file));
                            debugPrint('${file}: lastnawe da');
                          }

                          //[5] SEND TO SERVER
                          var response = await dioRequest.post(
                            "${a.baseUrlForImport}/my-information/change",
                            data: formData,
                          );
                          print('responw when post update profle $response');
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
                                  if (LocalStorageHelper.getValue("roleId") ==
                                      1) {
                                    setState(() {});
                                    argss['reloadProfile']();
                                  } else {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MainScreen(
                                                currentIndex: 3,
                                              )),
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                },
                              ).show();

                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: Text(LocalizationText.ok),
                              //     content: Container(
                              //       height: 120.0,
                              //       color: Colors.yellow,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(response.data['message'])
                              //         ],
                              //       ),
                              //     ),
                              //     actions: <Widget>[
                              //       TextButton(
                              //         onPressed: () => {
                              //           Navigator.pushAndRemoveUntil(
                              //             context,
                              //             MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     const MainScreen(
                              //                       currentIndex: 3,
                              //                     )),
                              //             (Route<dynamic> route) => false,
                              //           ),
                              //         },
                              //         child: Text(LocalizationText.ok),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            } else if (response.data['success'] == false) {
                              Loading.dismiss(context);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.topSlide,
                                title: LocalizationText.errorWhenCallApi,
                                desc: response.data['message'],
                                btnOkOnPress: () {},
                              ).show();
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: Text(LocalizationText.errPassOrEmail),
                              //     content: Container(
                              //       height: 120.0,
                              //       color: Colors.yellow,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           response?.data['data'] != null
                              //               ? Text(' ${response?.data['data']}')
                              //               : Text(
                              //                   '${LocalizationText.email}: ${response?.data['message']}'),
                              //         ],
                              //       ),
                              //     ),
                              //     actions: <Widget>[
                              //       TextButton(
                              //         onPressed: () => Navigator.pop(
                              //             context, LocalizationText.cancel),
                              //         child: Text(LocalizationText.ok),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            }
                          }
                          Loading.dismiss(context);
                        } on DioError catch (e) {
                          Loading.dismiss(context);
                          // The request was made and the server responded with a status code
                          // that falls out of the range of 2xx and is also not 304.
                          print(
                              'response dong 322: ${e.type} ${e.response?.statusCode}');
                          if (e.response != null) {
                            if (e.response?.data['success'] == true) {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: Text(LocalizationText.ok),
                              //     content: Container(
                              //       height: 120.0,
                              //       color: Colors.yellow,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Text(e.response?.data['message'])
                              //         ],
                              //       ),
                              //     ),
                              //     actions: <Widget>[
                              //       TextButton(
                              //         onPressed: () => {
                              //           Navigator.popAndPushNamed(
                              //               context, ProfilePage.routeName)
                              //         },
                              //         child: Text(LocalizationText.ok),
                              //       ),
                              //     ],
                              //   ),
                              // );

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.topSlide,
                                title: LocalizationText.editProfileSuccess,
                                desc: e.response?.data['message'],
                                btnOkOnPress: () {
                                  Navigator.popAndPushNamed(
                                      context, ProfilePage.routeName);
                                },
                              ).show();
                            } else if (e.response?.data['success'] == false) {
                              Loading.dismiss(context);

                              if (e.type == DioErrorType.badResponse &&
                                  e.response?.statusCode == 400) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.haveToFillInforFirst,
                                  desc: e.response?.data['data'] != null
                                      ? ' ${e.response?.data['data']}'
                                      : ' ${e.response?.data['message'][0]}',
                                  btnOkOnPress: () {
                                    Navigator.of(context).pushNamed(
                                        FillInforScreen.routeName,
                                        arguments: {
                                          "reloadProfile": () {
                                            setState(() {});
                                          }
                                        });
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
                                    Navigator.pop(
                                        context, LocalizationText.cancel);
                                  },
                                ).show();
                              }

                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) => AlertDialog(
                              //     title: Text(LocalizationText.errPassOrEmail),
                              //     content: Container(
                              //       height: 120.0,
                              //       color: Colors.yellow,
                              //       child: Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           e.response?.data['data'] != null
                              //               ? Text(
                              //                   ' ${e.response?.data['data']}')
                              //               : Text(
                              //                   ' ${e.response?.data['message'][0]}'),
                              //         ],
                              //       ),
                              //     ),
                              //     actions: <Widget>[
                              //       TextButton(
                              //         onPressed: () => Navigator.pop(
                              //             context, LocalizationText.cancel),
                              //         child: Text(LocalizationText.ok),
                              //       ),
                              //     ],
                              //   ),
                              // );
                            }
                          } else {
                            // Something happened in setting up or sending the request that triggered an Error
                            print(e.requestOptions);
                            print(e.message.runtimeType);
                          }
                        }
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
