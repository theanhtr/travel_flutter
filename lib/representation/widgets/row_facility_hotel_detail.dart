import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';

import '../../core/constants/dismention_constants.dart';

class RowDetailFacilityHotel extends StatefulWidget {
  RowDetailFacilityHotel({
    super.key,
    required this.facility,
    required this.icon,
    required this.checkBoxValue,
    required this.index,
  });
  final String facility;
  final Widget icon;
  final int index;
  bool? checkBoxValue;

  @override
  State<RowDetailFacilityHotel> createState() => _RowDetailFacilityHotelState();
}

class _RowDetailFacilityHotelState extends State<RowDetailFacilityHotel> {
  @override
  Widget build(BuildContext context) {
    print("widgit con ơ dây");
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                    child: Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: widget.icon,
                )),
                TextSpan(
                  text: widget.facility,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(24),
          //   decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(kDefaultPadding)),
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Checkbox(
                    value: widget.checkBoxValue,
                    activeColor: Colors.green,
                    onChanged: (bool? Value) {
                      setState(() {
                        widget.checkBoxValue = Value;
                      });
                      Text('Remember me');
                    }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
