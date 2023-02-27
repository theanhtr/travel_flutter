import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryColor = Color(0xff6155CC);
  static const Color secondColor = Color(0xff8F67E8);
  static const Color yellowColor = Color(0xffFE9C5E);
  static const Color opacityColor = Color(0xffE0DDF5);

  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color text1Color = Color(0xFF323B4B);
  static const Color subTitleColor = Color(0xFF838383);
  static const Color backgroundScaffoldColor = Color(0xFFF2F2F2);
  static const Color backgroundColor = Color(0xffFFFFFF);
  static const Color outBackgroundColor = Color(0xFF979797);
  static const Color noSelectbackgroundColor = Color(0xFF9d8ee1);
  static const Color cardBackgroundColor = Color.fromARGB(255, 218, 223, 239);
  static const Color blackTextColor = Colors.black;
  
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorPalette.secondColor,
      ColorPalette.primaryColor,
    ],
  );

  static Gradient outButtonGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorPalette.secondColor.withOpacity(0.2),
      ColorPalette.primaryColor.withOpacity(0.2),
    ],
  );
}
