import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/login_screen_controller.dart';
import 'package:travel_app_ytb/representation/controllers/user_controller.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/upload_image_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/line_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';

class FillInforScreen extends StatefulWidget {
  const FillInforScreen({super.key});

  static const String routeName = '/fill_person_infor_screen';

  @override
  State<FillInforScreen> createState() => _FillInforScreenState();
}

class _FillInforScreenState extends State<FillInforScreen> {
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String phone_number = "0986903302";
  DateTime date_of_birth = DateTime.now();
  XFile? image;
  UserController? _controller;
  late LoginManager log;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date_of_birth,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date_of_birth) {
      setState(() {
        date_of_birth = picked;
      });
    }
  }

// static Future<XFile> getImageXFileByUrl(String url) async {
//     var file = await DefaultCacheManager().getSingleFile(url);
//     XFile result = await XFile(file.path);
//     return result;
//   }
  @override
  Widget build(BuildContext context) {
    _controller = UserController();

    log = LoginManager();
    if (image != null) {
      debugPrint(image!.path);
    }
    return AppBarContainer(
      titleString: LocalizationText.fillInfoForm,
      implementLeading: true,
      // ignore: prefer_const_literals_to_create_immutables
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: kDefaultPadding * 5,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.firstName,
                onchange: (String value) {
                  firstName = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.lastName,
                onchange: (String value) {
                  lastName = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.phoneNumber,
                onchange: (String value) {
                  phone_number = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            Row(
              children: [
                StatefulBuilder(
                  builder: (context, setState) => Container(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(LocalizationText.dateofbirth),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 1.4,
                      vertical: kDefaultPadding / 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    color: ColorPalette.cardBackgroundColor,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 1.5),
                    child: Text(
                      "${date_of_birth}",
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorPalette.primaryColor, //font color
                        backgroundColor: Color.fromARGB(
                            252, 252, 247, 247), //background color
                        //text decoration 'underline' color
                        decorationThickness:
                            1.5, //decoration 'underline' thickness
                      ),
                    ),
                  ),
                )
              ],
            ),

            // const SizedBox(
            //   height: kDefaultPadding * 2,
            // ),

            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.email,
                onchange: (String value) {
                  email = value;
                  setState(() {});
                },
              ),
            ),
            Container(
              height: kMediumPadding * 7,
              child: UploadIamge(
                imagePath:
                    'https://0981-2405-4802-1d49-5c70-68b4-75ba-27c9-59b5.ngrok-free.app/uploads/Zqi6ut8OWnmPChLctU0HGtNj77GCWmjX_1681916482_d6041957-cd72-41d1-b4e8-0af084c544396367113315388879086.jpg',
                onchange: (XFile file) => {
                  setState(
                    () {
                      image = file;
                    },
                  )
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            ButtonWidget(
                title: LocalizationText.createInformationUser,
                ontap: () async {
                  Loading.show(context);

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
                    final token = await LocalStorageHelper.getValue("userToken")
                        as String?;
                    dioRequest.options.headers = {
                      'Authorization': 'Bearer ${token}',
                      'Accept': 'application/json'
                    };
                    //[3] ADDING EXTRA INFO
                    var formData = new dio.FormData.fromMap({
                      'first_name': '${userModel.firstName}',
                      'last_name': '${userModel.lastName}',
                      'date_of_birth': '${userModel.dateOfBirth}',
                      'phone_number': '${userModel.phoneNumber}',
                    });
                    //[4] ADD IMAGE TO UPLOAD
                    if (image != null) {
                      var file = await dio.MultipartFile.fromFile(image!.path,
                          filename: basename(image!.path),
                          contentType:
                              MediaType("image", basename(image!.path)));

                      formData.files.add(MapEntry('image', file));
                    }
                    //[5] SEND TO SERVER
                    var response = await dioRequest.post(
                      "https://0981-2405-4802-1d49-5c70-68b4-75ba-27c9-59b5.ngrok-free.app/api/my-information",
                      data: formData,
                    );
                    // Loading.dismiss(context);
                  } on DioError catch (e) {
                    Loading.dismiss(context);
                    // The request was made and the server responded with a status code
                    // that falls out of the range of 2xx and is also not 304.
                    if (e.response != null) {
                      print(e.response?.data['success']);

                      if (e.response?.data['success'] == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(LocalizationText.ok),
                            content: Container(
                              height: 120.0,
                              color: Colors.yellow,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocalizationText.successCreateUserInfo)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  e.response?.data['data'] != null
                                      ? Text(' ${e.response?.data['data']}')
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
                })
          ],
        ),
      ),
    );
  }
}
