import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class PropertyType extends StatefulWidget {
  const PropertyType({super.key});
  static const String routeName = '/facility_hotel_screen';
  @override
  State<PropertyType> createState() => _PropertyTypeState();
}

class _PropertyTypeState extends State<PropertyType> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        implementLeading: true,
        titleString: "Property type",
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
                    title: 'Done',
                    ontap: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
