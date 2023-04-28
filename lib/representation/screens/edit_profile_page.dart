// ignore_for_file: use_build_context_synchronously

import 'dart:io';

// import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/utils/user_preferences.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/user_controller.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/upload_image_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
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
  EditProfilePage({super.key});
  static const routeName = 'edit_profile_screen';
  late LoginManager log = LoginManager();
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
  String image = "";
  XFile? imageFileUpdate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime(1990, 8),
        initialDate: date_of_birth,
        lastDate: DateTime(2101));
    if (picked != null && picked != date_of_birth) {
      setState(() {
        date_of_birth = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = UserController();
    // debugPrint('${check}: check value');
    if (check == false) {
      email = LoginManager().userModel.email!;

      firstName = widget.log.userModelProfile.firstName.toString();
      lastName = widget.log.userModelProfile.lastName.toString();
      phone_number = widget.log.userModelProfile.phoneNumber.toString();
      date_of_birth =
          // DateTime.parse(widget.log.userModelProfile.dateOfBirth.toString());
          DateTime.parse(DateTime.now().toString());

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
                    imagePath: widget.log.userModelProfile.photoUrl.toString(),
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
                TextFieldWidget(
                  label: LocalizationText.firstname,
                  text: firstName,
                  onChanged: (name) {
                    setState(() {
                      firstName = name;
                    });
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: LocalizationText.lastname,
                  text: lastName,
                  onChanged: (name) {
                    setState(() {
                      lastName = name;
                    });
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: LocalizationText.email,
                  text: email,
                  onChanged: (email) {
                    setState(() {
                      this.email = email;
                    });
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: LocalizationText.phoneNumber,
                  text: phone_number,
                  onChanged: (phone_numbe) {
                    setState(() {
                      phone_number = phone_numbe;
                    });
                  },
                ),
                const SizedBox(height: 24),
                StatefulBuilder(
                  builder: (context, setState) => ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text("${date_of_birth.toLocal()}".split(' ')[0]),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text(LocalizationText.selectDate),
                        ),
                      ],
                    ),
                  ),
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
                            "https://0981-2405-4802-1d49-5c70-68b4-75ba-27c9-59b5.ngrok-free.app/api/my-information/change",
                            data: formData,
                          );
                          Loading.dismiss(context);
                          if (response != null) {
                            if (response?.data['success'] == true) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(LocalizationText.ok),
                                  content: Container(
                                    height: 120.0,
                                    color: Colors.yellow,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(response.data['message'])
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.popAndPushNamed(
                                            context, ProfilePage.routeName)
                                      },
                                      child: Text(LocalizationText.ok),
                                    ),
                                  ],
                                ),
                              );
                            } else if (response?.data['success'] == false) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(LocalizationText.errPassOrEmail),
                                  content: Container(
                                    height: 120.0,
                                    color: Colors.yellow,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        response?.data['data'] != null
                                            ? Text(' ${response?.data['data']}')
                                            : Text(
                                                '${LocalizationText.email}: ${response?.data['message']}'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          context, LocalizationText.cancel),
                                      child: Text(LocalizationText.ok),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          Loading.dismiss(context);
                        } on DioError catch (e) {
                          Loading.dismiss(context);
                          // The request was made and the server responded with a status code
                          // that falls out of the range of 2xx and is also not 304.
                          if (e.response != null) {
                            if (e.response?.data['success'] == true) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(LocalizationText.ok),
                                  content: Container(
                                    height: 120.0,
                                    color: Colors.yellow,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.response?.data['message'])
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.popAndPushNamed(
                                            context, ProfilePage.routeName)
                                      },
                                      child: Text(LocalizationText.ok),
                                    ),
                                  ],
                                ),
                              );
                            } else if (e.response?.data['success'] == false) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text(LocalizationText.errPassOrEmail),
                                  content: Container(
                                    height: 120.0,
                                    color: Colors.yellow,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        e.response?.data['data'] != null
                                            ? Text(
                                                ' ${e.response?.data['data']}')
                                            : Text(
                                                '${LocalizationText.email}: ${e.response?.data['message'][0]}'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          context, LocalizationText.cancel),
                                      child: Text(LocalizationText.ok),
                                    ),
                                  ],
                                ),
                              );
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
