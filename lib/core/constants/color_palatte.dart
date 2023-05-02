import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryColor = Color(0xff6155CC);
  static const Color secondColor = Color.fromARGB(255, 179, 166, 206);
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
  static const Color lightGray = Color.fromRGBO(189, 189, 189, 1);

  static const Color buttonReset1 = Color.fromARGB(255, 230, 223, 245);
  static const Color purpleLight = Color(0XFF1e224c);
  static const Color purpleDark = Color(0XFF0d193e);
  static const Color orange = Color(0XFFec8d2f);
  static const Color red = Color(0XFFf44336);
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

  static const Gradient defaultBackGroundButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorPalette.buttonReset1,
      ColorPalette.buttonReset1,
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
