import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final LatLng location;

  const GoogleMapWidget({super.key, required this.location});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    debugPrint("google map widget ${widget.location}");
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: widget.location,
        zoom: 15.0,
      ),
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('MyLocation'),
          position: widget.location,
        ),
      },
      gestureRecognizers: Set()
        ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
    );
  }
}
