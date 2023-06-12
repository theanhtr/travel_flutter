import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/utils/const_utils.dart';
import 'package:travel_app_ytb/helpers/hotelOwnerManager/hotel_owner_manager.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/representation/controllers/search_hotels_screen_controller.dart';
import 'package:travel_app_ytb/representation/controllers/search_your_destination_screen_controller.dart';
import 'package:travel_app_ytb/representation/models/hotel_model.dart';
import 'package:travel_app_ytb/representation/screens/hotelOwnerManager/owner_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';
import 'package:travel_app_ytb/representation/widgets/textfield_widget.dart';

import '../../../helpers/translations/localization_text.dart';
import '../../widgets/button_widget.dart';
import 'package:dio/dio.dart' as dio;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as p;

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:math';

// import 'package:imagepicker/videoPlayer.dart';
class UpdateHotelScreen extends StatefulWidget {
  UpdateHotelScreen({super.key});
  List<HotelModel>? listHotel = [];
  static const String routeName = '/update_hotel_screen';

  @override
  State<UpdateHotelScreen> createState() => _UpdateHotelScreenState();
}

class _UpdateHotelScreenState extends State<UpdateHotelScreen> {
  SearchYourDestinationScreenController? _controller;
  SearchHotelsScreenController? _controllerHotelScreen;
  HotelOwnerManager _hotelOwnerManager = HotelOwnerManager();
  final List<Map<String, dynamic>> provinceItems = [
    {"id": "0", "name": "None"}
  ];
  final List<Map<String, dynamic>> districtItems = [
    {"id": "0", "name": "None"}
  ];
  final List<Map<String, dynamic>> subDistrictItems = [
    {"id": "0", "name": "None"}
  ];
  bool isLoadProvince = false;
  bool isLoadDistricts = false;
  bool isLoadSubDistricts = false;
  var _documents = [];
  BaseClient a = BaseClient(LocalStorageHelper.getValue("userToken"));
  Map<String, dynamic>? selectedProvinceValue;
  Map<String, dynamic>? selectedDistrictValue;
  Map<String, dynamic>? selectedSubDistrictValue;
//caanf reset lai cai mang
  List<File> imageFileList = []; // List of selected image
  Map<String, dynamic>? imageAndIndex;
  List<Widget> listImageWidgets = [];
  List<Widget> listImageWidgetsFull = [];
  Widget imageWidget = Container();
  XFile? imageFileUpdate;
  List<XFile> xfilePick = [];
  String hotelName = "";
  String description = "";
  String specificAddress = "";
  final TextEditingController textEditingController = TextEditingController();
  var _image;
  var _video;
  bool check = false;
  final imagePicker = ImagePicker();
  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.

    return file;
  }

  void handleUpdateImage(int i) {}

  void handleWhenDisplayHotelImageChange() {
    imageWidget = Container();
    listImageWidgets = [];
    listImageWidgetsFull = [];
    debugPrint("dong 109");
    for (int i = 0; i < 3; i++) {
      if (imageFileList.length > 0) {
        if (i < 2) {
          if (i < imageFileList.length) {
            listImageWidgets.add(Expanded(
              flex: 1,
              child: TapableWidget(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(kMinPadding),
                            child: Image.file(
                              imageFileList[i],
                              fit: BoxFit.cover,
                            ),
                          )),
                        );
                      });
                },
                child: Container(
                    child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      child: Image.file(
                        imageFileList[i],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        right: -2,
                        top: -9,
                        child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Color.fromARGB(255, 0, 201, 251),
                              size: 18,
                            ),
                            onPressed: () => setState(() {
                                  if (imageFileList.length > 0) {
                                    imageFileList.removeAt(i);
                                    xfilePick = [];
                                    handleWhenDisplayHotelImageChange();
                                  }
                                }))),
                    Positioned(
                        left: -15,
                        top: -9,
                        child: IconButton(
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Color.fromARGB(255, 4, 239, 39),
                              size: 18,
                            ),
                            onPressed: () => {getImages(true, i)}))
                  ],
                )),
              ),
            ));
          } else {
            listImageWidgets.add(
              Expanded(flex: 1, child: Container()),
            );
          }
          listImageWidgets.add(
            SizedBox(
              width: kDefaultPadding,
            ),
          );
        } else if (i == 2) {
          if (i < imageFileList.length) {
            listImageWidgets.add(
              Expanded(
                flex: 1,
                child: TapableWidget(
                  onTap: () {
                    imageWidget = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listImageWidgetsFull,
                    );
                    setState(() {});
                  },
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                            child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(kMinPadding),
                              child: Image.file(
                                imageFileList[i],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                right: -2,
                                top: -9,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Color.fromARGB(255, 0, 201, 251),
                                      size: 18,
                                    ),
                                    onPressed: () => setState(() {
                                          if (imageFileList.length > 0) {
                                            imageFileList.removeAt(i);
                                            xfilePick = [];
                                            handleWhenDisplayHotelImageChange();
                                          }
                                        }))),
                            Positioned(
                                left: -15,
                                top: -9,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.edit_rounded,
                                      color: Color.fromARGB(255, 4, 239, 39),
                                      size: 18,
                                    ),
                                    onPressed: () => {getImages(true, i)}))
                          ],
                        )),
                        Container(
                          constraints: BoxConstraints(
                              minWidth: 100,
                              maxWidth: 100,
                              minHeight: 100,
                              maxHeight: 100),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(100, 0, 0, 0),
                            borderRadius: BorderRadius.circular(kMinPadding),
                          ),
                          child: Center(
                            child: Text(
                              "+${imageFileList.length - 2}",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            listImageWidgets.add(
              Expanded(flex: 1, child: Container()),
            );
          }
        }
      }
    }

    for (int i = 0; i < (imageFileList.length / 3).ceil(); i++) {
      List<Widget> listWidget = [];
      for (int j = i * 3; j < i * 3 + 3; j++) {
        if (j < i * 3 + 2) {
          if (j < imageFileList.length) {
            listWidget.add(Expanded(
              flex: 1,
              child: TapableWidget(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: Container(
                            child: Center(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(kMinPadding),
                                child: Image.file(
                                  imageFileList[j],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                    child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kMinPadding),
                      child: Image.file(
                        imageFileList[j],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        right: -2,
                        top: -9,
                        child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: Color.fromARGB(255, 0, 201, 251),
                              size: 18,
                            ),
                            onPressed: () => setState(() {
                                  if (imageFileList.length > 0) {
                                    imageFileList.removeAt(j);
                                    xfilePick = [];
                                    handleWhenDisplayHotelImageChange();
                                  }
                                }))),
                    Positioned(
                        left: -15,
                        top: -9,
                        child: IconButton(
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Color.fromARGB(255, 4, 239, 39),
                              size: 18,
                            ),
                            onPressed: () => {getImages(true, j)}))
                  ],
                )),
              ),
            ));
          } else {
            listWidget.add(
              Expanded(flex: 1, child: Container()),
            );
          }
          listWidget.add(
            SizedBox(
              width: kDefaultPadding,
            ),
          );
        } else if (j == i * 3 + 2) {
          if (j < imageFileList.length) {
            listWidget.add(
              Expanded(
                flex: 1,
                child: TapableWidget(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Scaffold(
                            body: Container(
                              child: Center(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(kMinPadding),
                                  child: Image.file(
                                    imageFileList[j],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                      child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kMinPadding),
                        child: Image.file(
                          imageFileList[j],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          right: -2,
                          top: -9,
                          child: IconButton(
                              icon: Icon(
                                Icons.cancel,
                                color: Color.fromARGB(255, 0, 201, 251),
                                size: 18,
                              ),
                              onPressed: () => setState(() {
                                    if (imageFileList.length > 0) {
                                      imageFileList.removeAt(j);
                                      xfilePick = [];
                                      handleWhenDisplayHotelImageChange();
                                    }
                                  }))),
                      Positioned(
                          left: -15,
                          top: -9,
                          child: IconButton(
                              icon: Icon(
                                Icons.edit_rounded,
                                color: Color.fromARGB(255, 4, 239, 39),
                                size: 18,
                              ),
                              onPressed: () => {getImages(true, j)}))
                    ],
                  )),
                ),
              ),
            );
          } else {
            listWidget.add(
              Expanded(flex: 1, child: Container()),
            );
          }
          break;
        }
      }

      listImageWidgetsFull.add(Row(
        children: listWidget,
      ));
      listImageWidgetsFull.add(
        SizedBox(
          height: kDefaultPadding,
        ),
      );
      if (i == (imageFileList.length) - 1) {
        listImageWidgetsFull.add(TapableWidget(
          onTap: () {
            imageWidget = Row(
              children: listImageWidgets,
            );
            setState(() {});
          },
          child: Text(
            "See Less",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 101, 88, 88)),
          ),
        ));
      }
    }
    imageWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listImageWidgetsFull,
    );
    debugPrint("dong 464: $imageWidget ");
    setState(() {});
  }

  Future getImages(bool isEdit, int picturePosition) async {
    final pickedFile = await imagePicker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000.0, maxWidth: 1000.0);
    xfilePick = pickedFile;
    imageWidget = Container();
    listImageWidgets = [];
    listImageWidgetsFull = [];
    debugPrint("dong 473: $picturePosition va $isEdit");
    setState(() {
      if (xfilePick.isNotEmpty) {
        if (isEdit == false) {
          for (var i = 0; i < xfilePick.length; i++) {
            imageFileList.add(File(xfilePick[i].path));
            imageAndIndex?.addAll(
              {'index': i, 'XfilePath': xfilePick[i].path},
            );
          }
        } else {
          imageFileList.insert(picturePosition, File(xfilePick[0].path));
          imageFileList.removeAt(picturePosition + 1);
        }
      }
    });
    handleWhenDisplayHotelImageChange();
  }

//anh

  void myAlert(BuildContext contextt) {
    // print(basename("hello"));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(LocalizationText.choseMedia),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImages(false, 0);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text(LocalizationText.fromGallery),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

// hàm vẽ ra main đây.
  @override
  Widget build(BuildContext context) {
    _controller = SearchYourDestinationScreenController();
    HotelOwnerManager _controllerHotel = HotelOwnerManager();

    if (check == false) {
      debugPrint(
          "dong 540: ${_controllerHotel.myHotelModel.address.toString()}");
      hotelName = _controllerHotel.myHotelModel.name.toString();
      description = _controllerHotel.myHotelModel.description.toString();
      specificAddress =
          _controllerHotel.myHotelModel.specific_address.toString();
      _controllerHotel.myHotelModel.listImagePathDynamic?.forEach((element) {
        debugPrint("dong 539");
        debugPrint(element.toString());
        urlToFile(element['path']).then((file) => {
              imageFileList.add(file),
              debugPrint(
                  "dong 723: ${imageFileList.length} va ${_hotelOwnerManager.myHotelModel.listImagePathDynamic?.length}"),
              if (imageFileList.length ==
                  _hotelOwnerManager.myHotelModel.listImagePathDynamic?.length)
                {
                  debugPrint("dong 550"),
                  handleWhenDisplayHotelImageChange(),
                }
            });
        debugPrint("dong 548");
      });
      setState(() {
        check = true;
      });
    }
    final Map<String, dynamic> argss =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    debugPrint(imageWidget.toString());
    if (isLoadProvince == false) {
      selectedProvinceValue =
          argss['selectedProvinceValue'] ?? {"id": "0", "name": "None"};
      selectedDistrictValue =
          argss['selectedDistrictValue'] ?? {"id": "0", "name": "None"};
      selectedSubDistrictValue =
          argss['selectedSubDistrictValue'] ?? {"id": "0", "name": "None"};
      _controller?.getProvince().then((province) => {
            if (province.runtimeType == List)
              {
                province as List,
                province.forEach((element) {
                  if (element['name'] ==
                      _controllerHotel.myHotelModel.province) {
                    selectedProvinceValue = element;
                  }
                  provinceItems.add(element);
                }),
              },
            _controller
                ?.getDistricts(selectedProvinceValue?['id'].toString() ?? "")
                .then((district) => {
                      if (district.runtimeType == List)
                        {
                          // debugPrint("dong 731"),
                          district as List,
                          district.forEach((element) {
                            // debugPrint(element['name']);
                            if (element['name'] ==
                                _controllerHotel.myHotelModel.district) {
                              selectedDistrictValue = element;
                            }
                            districtItems.add(element);
                          }),
                        },
                      _controller
                          ?.getSubDistricts(
                              selectedDistrictValue?['id'].toString() ?? "")
                          .then((subDistrict) => {
                                if (subDistrict.runtimeType == List)
                                  {
                                    subDistrict as List,
                                    subDistrict.forEach((element) {
                                      if (element['name'] ==
                                          _controllerHotel
                                              .myHotelModel.sub_district) {
                                        selectedSubDistrictValue = element;
                                      }
                                      subDistrictItems.add(element);
                                    }),
                                  },
                                setState(() {
                                  isLoadProvince = true;
                                })
                              })
                    })
          });
    }
    if (provinceItems.isEmpty == false &&
        districtItems.isEmpty == false &&
        subDistrictItems.isEmpty == false) {
      return AppBarContainer(
          implementLeading: true,
          titleString: LocalizationText.updateMyhotel,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.hotelName,
                    text: hotelName,
                    onChanged: (name) {
                      setState(() {
                        hotelName = name;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.hotelDescription,
                    text: description,
                    onChanged: (name) {
                      setState(() {
                        description = name;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                StatefulBuilder(
                  builder: (context, setState) => TextFieldWidget(
                    label: LocalizationText.hotelSpecificAddress,
                    text: specificAddress,
                    onChanged: (name) {
                      setState(() {
                        specificAddress = name;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: StatefulBuilder(builder: (context, setState) {
                    return BookingHotelTab(
                      icon: FontAwesomeIcons.creativeCommonsBy,
                      title: LocalizationText.addHotelImage,
                      description: '',
                      sizeItem: kDefaultIconSize,
                      sizeText: kDefaultIconSize / 1.2,
                      primaryColor: const Color(0xffF77777),
                      secondaryColor: const Color(0xffF77777).withOpacity(0.2),
                      implementSetting: true,
                      ontap: () {
                        myAlert(context);
                      },
                      //         child: Text(LocalizationText.selectDate),
                      iconString: '',
                    );
                  }),
                ),
                const SizedBox(height: 24),
                imageFileList.length > 0
                    ? imageWidget
                    : Center(child: Text('Sorry nothing selected!!')),
                const SizedBox(height: 24),
                DropdownSearch<Map<String, dynamic>>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: false,
                  ),
                  items: provinceItems,
                  itemAsString: (Map<String, dynamic> value) => value['name'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      labelText: "Province",
                      hintText: "Province in mode",
                    ),
                  ),
                  onChanged: (value) {
                    selectedProvinceValue = value;
                    setState(() {
                      isLoadDistricts = false;
                    });
                    if (isLoadDistricts == false) {
                      _controller
                          ?.getDistricts(
                              selectedProvinceValue?['id'].toString() ?? "")
                          .then((district) => {
                                districtItems.clear(),
                                districtItems.add({"id": "0", "name": "None"}),
                                if (district.runtimeType == List)
                                  {
                                    district as List,
                                    district.forEach((element) {
                                      // if (element['name'] ==
                                      //     _controllerHotel
                                      //         .myHotelModel.district) {
                                      //   selectedDistrictValue = element;
                                      // }
                                      districtItems.add(element);
                                    }),
                                    setState(() {
                                      isLoadDistricts = true;
                                    })
                                  }
                              });
                    }
                  },
                  selectedItem: selectedProvinceValue,
                ),
                const SizedBox(height: 24),
                DropdownSearch<Map<String, dynamic>>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: false,
                  ),
                  items: districtItems,
                  itemAsString: (Map<String, dynamic> value) => value['name'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      labelText: "District",
                      hintText: "District in mode",
                    ),
                  ),
                  onChanged: (value) {
                    selectedDistrictValue = value;
                    setState(() {
                      isLoadSubDistricts = false;
                    });
                    if (isLoadSubDistricts == false) {
                      _controller
                          ?.getSubDistricts(
                              selectedDistrictValue?['id'].toString() ?? "")
                          .then((subDistrict) => {
                                subDistrictItems.clear(),
                                subDistrictItems
                                    .add({"id": "0", "name": "None"}),
                                if (subDistrict.runtimeType == List)
                                  {
                                    subDistrict as List,
                                    subDistrict.forEach((element) {
                                      // if (element['name'] ==
                                      //     _controllerHotel
                                      //         .myHotelModel.sub_district) {
                                      //   selectedSubDistrictValue = element;
                                      // }
                                      subDistrictItems.add(element);
                                    }),
                                    setState(() {
                                      isLoadSubDistricts = true;
                                    })
                                  }
                              });
                    }
                  },
                  selectedItem: selectedDistrictValue,
                ),
                const SizedBox(height: 24),
                DropdownSearch<Map<String, dynamic>>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: false,
                  ),
                  items: subDistrictItems,
                  itemAsString: (Map<String, dynamic> value) => value['name'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      labelText: "Sub district",
                      hintText: "SubDistrict in mode",
                    ),
                  ),
                  onChanged: (value) {
                    selectedSubDistrictValue = value;
                  },
                  selectedItem: selectedSubDistrictValue,
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonWidget(
                  title: LocalizationText.updateMyhotel,
                  ontap: () async {
                    {
                      Loading.show(context);
                      // debugPrint('${lastName}: lastname value');

                      try {
                        ///[1] CREATING INSTANCE
                        bool change_address = false;
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
                        // print('$_documents');
                        print('$hotelName');

                        if (selectedProvinceValue ==
                                {"id": "0", "name": "None"} ||
                            selectedDistrictValue ==
                                {"id": "0", "name": "None"} ||
                            selectedSubDistrictValue ==
                                {"id": "0", "name": "None"} ||
                            hotelName == "") {
                          // ignore: use_build_context_synchronously
                          Loading.dismiss(context);
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.topSlide,
                            title: LocalizationText.fieldsHavenotFill,
                            desc: LocalizationText.haveToFillInforFirst,
                            btnOkOnPress: () {},
                          ).show();
                        } else {
                          if (selectedProvinceValue!['name'] !=
                                  _controllerHotel.myHotelModel.province ||
                              selectedDistrictValue!['name'] !=
                                  _controllerHotel.myHotelModel.district ||
                              selectedSubDistrictValue!['name'] !=
                                  _controllerHotel.myHotelModel.sub_district ||
                              specificAddress !=
                                  _controllerHotel
                                      .myHotelModel.specific_address) {
                            debugPrint("dong 871");
                            change_address = true;
                          }
                          debugPrint(
                              "dong 867: ${selectedProvinceValue?['name'].toString()} ${selectedDistrictValue?['name'].toString()} ${selectedSubDistrictValue?['name'].toString()} ${change_address}");
                          await _controllerHotel
                              .updateHotels(
                                  selectedProvinceValue?['id'].toString() ?? "",
                                  selectedDistrictValue?['id'].toString() ?? "",
                                  selectedSubDistrictValue?['id'].toString() ??
                                      "",
                                  hotelName,
                                  description,
                                  specificAddress,
                                  change_address)
                              .then((value) async {
                            print("dong 878: ${value['success']}");
                            if (value['result'] == '400') {
                              Loading.dismiss(context);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.topSlide,
                                title: LocalizationText.errorWhenCallApi,
                                desc: LocalizationText.hotelManagerExist,
                                btnOkOnPress: () {},
                              ).show();
                            } else if (value['success'] == true) {
                              String idList = "";
                              var path;
                              var payload;
                              var response;

                              _controllerHotel.myHotelModel.listImagePathDynamic
                                  ?.forEach((element) {
                                idList += ',${element['id']}';
                              });

                              debugPrint("dong 912: $idList");
                              if (_controllerHotel.myHotelModel
                                      .listImagePathDynamic!.length >
                                  0) {
                                _controllerHotel
                                    .deleteImageHotel(idList)
                                    .then((value) async => {
                                          debugPrint("dong 913: $value"),
                                          if (value['result'] != null)
                                            {
                                              Loading.dismiss(context),
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.warning,
                                                animType: AnimType.topSlide,
                                                title: value['result'],
                                                desc: LocalizationText
                                                    .hotelManagerExist,
                                                btnOkOnPress: () {},
                                              ).show()
                                            }
                                          else
                                            {
                                              if (imageFileList.length > 0)
                                                {
                                                  for (int i = 0;
                                                      i < imageFileList.length;
                                                      i++)
                                                    {
                                                      path =
                                                          imageFileList[i].path,
                                                      _documents.add(
                                                          await MultipartFile
                                                              .fromFile(path,
                                                                  filename: path
                                                                      .split(
                                                                          '/')
                                                                      .last)),
                                                    },
                                                  payload =
                                                      dio.FormData.fromMap({
                                                    'images[]': _documents
                                                  }),
                                                  response =
                                                      await dioRequest.post(
                                                    "${a.baseUrlForImport}/my-hotel/images",
                                                    data: payload,
                                                  ),
                                                  print(
                                                      'responw when post update profle $response'),
                                                  Loading.dismiss(context),
                                                  if (response != null)
                                                    {
                                                      debugPrint(
                                                          "succeess update response: ${response.data}"),
                                                      if (response.data[
                                                              'success'] ==
                                                          true)
                                                        {
                                                          // LoginManager().setUserProfileModel();
                                                          // ignore: use_build_context_synchronously
                                                          Loading.dismiss(
                                                              context),
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .success,
                                                            animType: AnimType
                                                                .topSlide,
                                                            title: LocalizationText
                                                                .updateMyhotel,
                                                            desc: LocalizationText
                                                                .updateMyhotelSuccess,
                                                            btnOkOnPress:
                                                                () async {
                                                              _documents = [];
                                                              debugPrint(argss[
                                                                      'setSectiond']
                                                                  .runtimeType
                                                                  .toString());

                                                              List<HotelModel>
                                                                  listHotel =
                                                                  [];

                                                              List<dynamic>
                                                                  images;
                                                              String imagePath =
                                                                  "";
                                                              String address;
                                                              double
                                                                  distanceInfo =
                                                                  0;
                                                              HotelModel hotel;
                                                              dynamic
                                                                  elementDetail;
                                                              await _controllerHotelScreen
                                                                  ?.getHotelDetail(
                                                                      _controllerHotel
                                                                          .myHotelModel
                                                                          .id!)
                                                                  .then(
                                                                      (value) =>
                                                                          {
                                                                            // print("Value search dayyyyyyyyR"),
                                                                            elementDetail =
                                                                                value,
                                                                            images =
                                                                                elementDetail['images'],
                                                                            debugPrint("dong 1019: ${elementDetail['address']['specific_address']}"),
                                                                            address =
                                                                                "${elementDetail['address']['specific_address']}, ${elementDetail['address']['sub_district']}, ${elementDetail['address']['district']}, ${elementDetail['address']['province']}",
                                                                            if (images.isEmpty)
                                                                              {
                                                                                imagePath = ConstUtils.imgHotelDefault,
                                                                              }
                                                                            else
                                                                              {
                                                                                imagePath = elementDetail['images'][0]['path'] ?? "",
                                                                              },
                                                                            debugPrint(elementDetail['images'].runtimeType.toString()),
                                                                            hotel = HotelModel(
                                                                                specific_address: elementDetail['address']['specific_address'],
                                                                                imageFilePath: imagePath,
                                                                                name: elementDetail['name'],
                                                                                address: address,
                                                                                locationInfo: elementDetail['address_id'].toString(),
                                                                                distanceInfo: distanceInfo.toString(),
                                                                                starInfo: elementDetail['rating_average'] + 0.0,
                                                                                countReviews: elementDetail['count_review'],
                                                                                priceInfo: "${elementDetail['min_price']} - ${elementDetail['max_price']}",
                                                                                id: elementDetail['id'],
                                                                                district: elementDetail['address']['district'],
                                                                                sub_district: elementDetail['address']['sub_district'],
                                                                                description: elementDetail['description'],
                                                                                province: elementDetail['address']['province'],
                                                                                listImagePathDynamic: elementDetail['images']),
                                                                            _hotelOwnerManager.setMyhotelModel(hotel)
                                                                          });
                                                              setState(() {
                                                                check = false;
                                                              });
                                                              Navigator.popAndPushNamed(
                                                                  context,
                                                                  HotelOwnerScreen
                                                                      .routeName);
                                                            },
                                                          ).show(),
                                                        }
                                                      else if (response.data[
                                                              'success'] ==
                                                          false)
                                                        {
                                                          Loading.dismiss(
                                                              context),
                                                          _documents = [],
                                                          // ignore: use_build_context_synchronously
                                                          AwesomeDialog(
                                                            context: context,
                                                            dialogType:
                                                                DialogType
                                                                    .warning,
                                                            animType: AnimType
                                                                .topSlide,
                                                            title: LocalizationText
                                                                .errorWhenCallApi,
                                                            desc: response.data[
                                                                'message'],
                                                            btnOkOnPress: () {},
                                                          ).show(),
                                                        }
                                                    }
                                                },
                                            }
                                        });
                              } else if (_controllerHotel.myHotelModel
                                          .listImagePathDynamic!.length ==
                                      0 &&
                                  imageFileList.length > 0) {
                                for (int i = 0; i < imageFileList.length; i++) {
                                  path = imageFileList[i].path;
                                  _documents.add(await MultipartFile.fromFile(
                                      path,
                                      filename: path.split('/').last));
                                }
                                ;
                                payload = dio.FormData.fromMap(
                                    {'images[]': _documents});

                                response = await dioRequest.post(
                                  "${a.baseUrlForImport}/my-hotel/images",
                                  data: payload,
                                );
                                print(
                                    'responw when post update profle $response');

                                if (response != null) {
                                  debugPrint(
                                      "succeess update response: ${response.data}");
                                  if (response.data['success'] == true) {
                                    Loading.dismiss(context);
                                    // LoginManager().setUserProfileModel();
                                    // ignore: use_build_context_synchronously
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.topSlide,
                                      title: LocalizationText.updateMyhotel,
                                      desc:
                                          LocalizationText.updateMyhotelSuccess,
                                      btnOkOnPress: () async {
                                        _documents = [];
                                        debugPrint(argss['setSectiond']
                                            .runtimeType
                                            .toString());
                                        List<HotelModel> listHotel = [];

                                        List<dynamic> images;
                                        String imagePath = "";
                                        String address;
                                        double distanceInfo = 0;
                                        HotelModel hotel;
                                        dynamic elementDetail;
                                        await _controllerHotelScreen
                                            ?.getHotelDetail(_controllerHotel
                                                .myHotelModel.id!)
                                            .then((value) => {
                                                  // print("Value search dayyyyyyyyR"),
                                                  elementDetail = value,
                                                  images =
                                                      elementDetail['images'],
                                                  debugPrint(
                                                      "dong 1201: ${elementDetail['address']['specific_address']}"),
                                                  address =
                                                      "${elementDetail['address']['specific_address']}, ${elementDetail['address']['sub_district']}, ${elementDetail['address']['district']}, ${elementDetail['address']['province']}",
                                                  if (images.isEmpty)
                                                    {
                                                      imagePath = ConstUtils
                                                          .imgHotelDefault,
                                                    }
                                                  else
                                                    {
                                                      imagePath = elementDetail[
                                                                  'images'][0]
                                                              ['path'] ??
                                                          "",
                                                    },
                                                  debugPrint(
                                                      elementDetail['images']
                                                          .runtimeType
                                                          .toString()),
                                                  hotel = HotelModel(
                                                      specific_address: elementDetail['address']
                                                          ['specific_address'],
                                                      imageFilePath: imagePath,
                                                      name:
                                                          elementDetail['name'],
                                                      address: address,
                                                      locationInfo:
                                                          elementDetail['address_id']
                                                              .toString(),
                                                      distanceInfo: distanceInfo
                                                          .toString(),
                                                      starInfo: elementDetail[
                                                              'rating_average'] +
                                                          0.0,
                                                      countReviews: elementDetail[
                                                          'count_review'],
                                                      priceInfo:
                                                          "${elementDetail['min_price']} - ${elementDetail['max_price']}",
                                                      id: elementDetail['id'],
                                                      district:
                                                          elementDetail['address']
                                                              ['district'],
                                                      sub_district:
                                                          elementDetail['address']
                                                              ['sub_district'],
                                                      description: elementDetail[
                                                          'description'],
                                                      province:
                                                          elementDetail['address']
                                                              ['province'],
                                                      listImagePathDynamic:
                                                          elementDetail['images']),
                                                  _hotelOwnerManager
                                                      .setMyhotelModel(hotel)
                                                });
                                        setState(() {
                                          check = false;
                                        });
                                        Navigator.popAndPushNamed(context,
                                            HotelOwnerScreen.routeName);
                                      },
                                    ).show();
                                  } else if (response.data['success'] ==
                                      false) {
                                    Loading.dismiss(context);
                                    _documents = [];
                                    // ignore: use_build_context_synchronously
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
                              } else {
                                debugPrint(
                                    "dong 1074 check xem path length co > 1 khong");
                                Loading.dismiss(context);

                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.topSlide,
                                  title: LocalizationText.updateMyhotel,
                                  desc: LocalizationText.updateMyhotelSuccess,
                                  btnOkOnPress: () {
                                    _documents = [];
                                    if (LocalStorageHelper.getValue("roleId") ==
                                        1) {
                                      setState(() {});
                                      argss['reloadProfile']();
                                    } else {
                                      Navigator.popAndPushNamed(
                                          context, HotelOwnerScreen.routeName);
                                    }
                                  },
                                ).show();
                                Loading.dismiss(context);
                              }
                            }
                          });
                        }
                      } on dio.DioError catch (e) {
                        Loading.dismiss(context);
                        // The request was made and the server responded with a status code
                        // that falls out of the range of 2xx and is also not 304.
                        print(
                            'response dong 322: ${e.type} ${e.response?.statusCode}');
                        if (e.response != null) {
                          if (e.response?.data['success'] == true) {
                            // AwesomeDialog(
                            //   context: context,
                            //   dialogType: DialogType.success,
                            //   animType: AnimType.topSlide,
                            //   title: LocalizationText.editProfileSuccess,
                            //   desc: e.response?.data['message'],
                            //   btnOkOnPress: () {
                            //     Navigator.popAndPushNamed(
                            //         context, ProfilePage.routeName);
                            //   },
                            // ).show();
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
                              Loading.dismiss(context);
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
                          print(e.requestOptions);
                          print(e.message.runtimeType);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ));
    }

    return AppBarContainer(
        implementLeading: true,
        titleString: LocalizationText.updateMyhotel,
        child: Column(
          children: const [
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
