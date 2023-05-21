import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:translator/translator.dart';

class LocationHelper {
  static final LocationHelper _shared = LocationHelper.internal();

  factory LocationHelper() {
    return _shared;
  }

  LocationHelper.internal();
  Future<void> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<Position> _determinePosition() async {
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getDistanceInformation(String address) async {
    final translator = GoogleTranslator();
    var translateAddress = await translator.translate(address, to: 'vi');
    Location geoPointFromAddress = await getGeoPointFromAddress(translateAddress.text);
    Position currentPosition = await _determinePosition();
    double distanceInMeters = Geolocator.distanceBetween(currentPosition.latitude, currentPosition.longitude, geoPointFromAddress.latitude, geoPointFromAddress.longitude);
    return (distanceInMeters/1000).toStringAsFixed(2);
  }

  Future<Location> getGeoPointFromAddress(String address) async {
    debugPrint("address $address");
    locationFromAddress(address).then((value) => {
      debugPrint("location $value"),
    }, onError: (error) {
      debugPrint("error $error");
    });
    final List<Location> locations = await locationFromAddress(address).catchError( (err) {
      debugPrint("60 location helper $err");
      return Future.value([Location(latitude: 10.8231, longitude: 106.6297, timestamp: DateTime.now())]);
    });
    if (locations.isNotEmpty) {
      final Location location = locations.first;
      return location;
    } else {
      return Location(latitude: 0, longitude: 0, timestamp: DateTime.now());
    }
  }
}
