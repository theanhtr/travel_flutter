import 'package:google_maps_flutter/google_maps_flutter.dart';

//  "${elementDetail['address']['specific_address']}, ${elementDetail['address']['sub_district']}, ${elementDetail['address']['district']}, ${elementDetail['address']['province']}"
class HotelModel {
  int? id;
  String? imageFilePath;
  List<String>? listImageDetailPath;
  String? name;
  String? locationInfo;
  String? distanceInfo;
  String? address;
  double? starInfo;
  int? countReviews;
  String? priceInfo;
  String? description;
  String? locationSpecial;
  List<String>? services;
  bool? isLike;
  LatLng? position;
  String? sub_district;
  String? district;
  String? province;
  String? specific_address;
  List<dynamic>? listImagePathDynamic;
  HotelModel(
      {this.id,
      this.specific_address,
      this.listImagePathDynamic,
      this.imageFilePath,
      this.listImageDetailPath,
      this.name,
      this.locationInfo,
      this.distanceInfo,
      this.starInfo,
      this.countReviews,
      this.priceInfo,
      this.description,
      this.address,
      this.locationSpecial,
      this.services,
      this.isLike,
      this.position,
      this.district,
      this.sub_district,
      this.province});
}
