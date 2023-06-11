import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';

class ImageHelper {
  static Widget loadFromAsset(
    String imageFilePath, {
    double? width,
    double? height,
    BorderRadius? radius,
    BoxFit? fit,
    Color? tintColor,
    Alignment? alignment,
  }) {
    return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: Image.asset(
          imageFilePath,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: tintColor,
          alignment: alignment ?? Alignment.center,
        ));
  }

  static Widget loadFromNetwork(
    String imageFilePath, {
    double? width,
    double? height,
    BorderRadius? radius,
    BoxFit? fit,
    Color? tintColor,
    Alignment? alignment,
  }) {
    return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: Image.network(
          imageFilePath,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: tintColor,
          alignment: alignment ?? Alignment.center,
          errorBuilder: (BuildContext buildContext, Object exception,
              StackTrace? stackTrace) {
            return Image.asset(
              AssetHelper.notFound,
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              color: tintColor,
              alignment: alignment ?? Alignment.center,
            );
          },
        ));
  }
}
