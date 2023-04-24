import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  HotelModel({
    this.id,
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
  });
}
