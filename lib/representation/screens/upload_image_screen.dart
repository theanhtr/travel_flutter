import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/profile_widget.dart';

class UploadIamge extends StatefulWidget {
  static const String routename = '/upload_image_screen';
  late LoginManager log = LoginManager();
  bool isEdit;
  UploadIamge(
      {required this.onchange, required this.imagePath, required this.isEdit});
  final Function onchange;
  String imagePath;
  @override
  _UploadIamgeState createState() => _UploadIamgeState();
}

class _UploadIamgeState extends State<UploadIamge> {
  XFile? image;
  bool? test;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    print("dong so 27 upload_image");
    debugPrint(img!.path);
    setState(() {
      image = img;
      widget.imagePath = img.path;
      test = true;
    });
    widget.onchange(image);
    debugPrint('anhr dong 34: ${image}');
  }

  //show popup dialog
  void myAlert() {
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
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text(LocalizationText.fromGallery),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text(LocalizationText.fromCamera),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('anhr: ${image} va ${test}');
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileWidget(
                imagePath: widget.imagePath,
                isEdit: widget.isEdit,
                onClicked: () {
                  myAlert();
                },
              ),

              SizedBox(
                height: 20,
              ),
              //if image not null show the image
              //if image null show text
              // image != null
              //     ? Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 5),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(8),
              //           child: Image.file(
              //             //to show image, you type like this.
              //             File(image!.path),
              //             fit: BoxFit.cover,
              //             width: MediaQuery.of(context).size.width,
              //             height: 200,
              //           ),
              //         ),
              //       )
              //     : Text(
              //         LocalizationText.noImage,
              //         style: TextStyle(fontSize: 16),
              //       )
            ],
          ),
        ),
      ),
    );
  }
}
