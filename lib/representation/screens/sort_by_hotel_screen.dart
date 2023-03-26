import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class SortByHotel extends StatefulWidget {
  const SortByHotel({super.key});
  static const String routeName = '/sort_by_hotel_screen';
  @override
  State<SortByHotel> createState() => _SortByHotelState();
}

class _SortByHotelState extends State<SortByHotel> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        implementLeading: true,
        titleString: "Sort by",
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: kMediumPadding * 2,
                ),
                Container(
                  margin: const EdgeInsets.only(top: kDefaultPadding),
                  child: ButtonWidget(
                    title: 'Apply',
                    ontap: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
