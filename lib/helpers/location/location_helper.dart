import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:translator/translator.dart';

class LocationHelper {
  static final LocationHelper _shared = LocationHelper.internal();

  factory LocationHelper() {
    return _shared;
  }

  LocationHelper.internal();

  Future<Position> determinePosition() async {
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

    return await Geolocator.getCurrentPosition();
  }

  Future<double> getDistanceInformation(String address) async {
    final translator = GoogleTranslator();
    var translateAddress = await translator.translate(address, to: 'en');
    debugPrint(translateAddress.text);
    List<Location> locations = await locationFromAddress(translateAddress.text);
    Location geoPointFromAddress = locations.isNotEmpty ? locations[0] : Location(latitude: 0, longitude: 0, timestamp: DateTime.now());
    Position currentPosition = await determinePosition();
    double distanceInMeters = Geolocator.distanceBetween(currentPosition.latitude, currentPosition.longitude, geoPointFromAddress.latitude, geoPointFromAddress.longitude);
    return distanceInMeters;
  }

}
