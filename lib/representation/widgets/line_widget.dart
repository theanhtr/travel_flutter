import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';

class Line extends StatelessWidget {
  const Line({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: width,
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 210, 215, 226)),
    );
  }
}
