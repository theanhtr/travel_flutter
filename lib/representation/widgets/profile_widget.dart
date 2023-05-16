import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image;

    debugPrint('iamgePath: ${imagePath} va ${imagePath.runtimeType} ');
    if (isEdit == true && imagePath != "null") {
      return GestureDetector(
        onTap: onClicked,
        child: ClipOval(
          child: Material(
            shape: CircleBorder(
              side: const BorderSide(color: ColorPalette.yellowColor, width: 3),
            ),
            child: ClipRRect(
              child: Image.file(
                //to show image, you type like this.
                File(imagePath),
                fit: BoxFit.cover,
                width: 128,
                height: 128,
              ),
            ),
          ),
        ),
      );
    }
    if (imagePath == "null") {
      image = NetworkImage(
          "https://cdn.mos.cms.futurecdn.net/JarKa4TVZxSCuN8x8WNPSN.jpg");
    } else {
      image = NetworkImage(imagePath);
    }
    return ClipOval(
      child: Material(
        shape: CircleBorder(
          side: const BorderSide(color: ColorPalette.yellowColor, width: 3),
        ),
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
