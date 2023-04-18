import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String currentPosition = "";

  @override
  Widget build(BuildContext context) {
    LocationHelper().getDistanceInformation("Hà Nội, Nam Từ Liêm");
    return Center(
      child: Text(
          currentPosition,
          style: TextStyle(
            color: Colors.black
          ),
      ),
    );
  }
}