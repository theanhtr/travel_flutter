import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/user_controller.dart';
import 'package:travel_app_ytb/representation/models/user_model.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';
import 'package:travel_app_ytb/representation/screens/profile_screen.dart';
import 'package:travel_app_ytb/representation/screens/upload_image_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'package:travel_app_ytb/representation/widgets/textfield_widget.dart';

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
  String phone_number = "";
  DateTime date_of_birth = DateTime.now();
  XFile? image;
  UserController? _controller;
  bool checkSelectDate = false;

  BaseClient a = BaseClient(LocalStorageHelper.getValue("userToken") as String);

  // late LoginManager log;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date_of_birth,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date_of_birth) {
      setState(() {
        date_of_birth = picked;
        checkSelectDate = true;
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
    final Map<String, dynamic> argss =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print("dong 72");

    _controller = UserController();
    if (checkSelectDate == true) {
      print("$date_of_birth");
    }
    // log = LoginManager();
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
            Container(
              height: kMediumPadding * 7,
              child: UploadIamge(
                isEdit: image != null ? true : false,
                imagePath: image?.path ?? ConstUtils.defaultImageAvatar,
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
              height: kDefaultPadding * 3,
            ),
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
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
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
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
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
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: StatefulBuilder(builder: (context, setState) {
                return BookingHotelTab(
                  icon: FontAwesomeIcons.calendarDay,
                  title: LocalizationText.dateofbirth,
                  description: "${date_of_birth.toLocal()}".split(' ')[0],
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
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
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
            const SizedBox(
              height: kDefaultPadding * 3,
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
                    final token =
                        LocalStorageHelper.getValue("userToken") as String;

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
                    // [5] SEND TO SERVER
                    var response = await dioRequest.post(
                      "${a.baseUrlForImport}/my-information",
                      data: formData,
                    );
                    Loading.dismiss(context);

                    if (response?.data['success'] == true) {
                      // ignore: use_build_context_synchronously
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) => AlertDialog(
                      //     title: Text(LocalizationText.ok),
                      //     content: Container(
                      //       height: 120.0,
                      //       color: Colors.yellow,
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(LocalizationText.successCreateUserInfo)
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

                      // ignore: use_build_context_synchronously
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.topSlide,
                        title: LocalizationText.ok,
                        desc: LocalizationText.successCreateUserInfo,
                        btnOkOnPress: () {
                          argss["reloadProfile"]();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen(
                                      currentIndex: 3,
                                    )),
                            (Route<dynamic> route) => false,
                          );
                          // Navigator.popAndPushNamed(
                          //     context, LoginScreen.routeName);
                        },
                      ).show();
                    }
                  } on DioError catch (e) {
                    Loading.dismiss(context);
                    // The request was made and the server responded with a status code
                    // that falls out of the range of 2xx and is also not 304.
                    if (e.response != null) {
                      print(e.response?.data['success']);
                      print(e);
                      if (e.response?.data['success'] == false) {
                        AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.topSlide,
                                title: LocalizationText.errorWhenCallApi,
                                desc: e.response?.data['data'] != null
                                    ? ' ${e.response?.data['data']}'
                                    : '${e.response?.data['message'][0]}',
                                btnOkOnPress: () {})
                            .show();
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) => AlertDialog(
                        //     title: Text(LocalizationText.errPassOrEmail),
                        //     content: Container(
                        //       height: 120.0,
                        //       color: Colors.yellow,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           e.response?.data['data'] != null
                        //               ? Text(' ${e.response?.data['data']}')
                        //               : Text(
                        //                   '${LocalizationText.email}: ${e.response?.data['message'][0]}'),
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
                })
          ],
        ),
      ),
    );
  }
}
