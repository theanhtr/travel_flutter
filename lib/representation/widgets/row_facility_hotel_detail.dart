import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';

import '../../core/constants/dismention_constants.dart';

class RowDetailFacilityHotel extends StatefulWidget {
  RowDetailFacilityHotel({
    super.key,
    required this.facility,
    required this.icon,
    required this.checkBoxValue,
    required this.index,
    this.getCheckBoxValue,
  });
  final String facility;
  final Widget icon;
  final int index;
  bool? checkBoxValue;
  final Function(bool)? getCheckBoxValue;

  @override
  State<RowDetailFacilityHotel> createState() => _RowDetailFacilityHotelState();
}

class _RowDetailFacilityHotelState extends State<RowDetailFacilityHotel> {
  // ignore: unused_field
  @override
  Widget build(BuildContext context) {
    print(widget.checkBoxValue);
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
                  ),
                ),
                TextSpan(
                  text: widget.facility,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child:
                // Column(
                //   children: <Widget>[
                Checkbox(
              value: widget.checkBoxValue,
              activeColor: Colors.green,
              onChanged: (bool? Value) {
                setState(() {
                  widget.checkBoxValue = Value;
                  widget.getCheckBoxValue!(Value!);
                });
                Text('Remember me');
              },
            ),
            // ],
            // ),
          )
        ],
      ),
    );
  }
}

class DropdownButtonCustom extends StatefulWidget {
  const DropdownButtonCustom({super.key});

  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  String? _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedLocation,
      dropdownColor: ColorPalette.noSelectbackgroundColor,
      items: <String>['Admin', 'Customer', 'Hotel Manager', 'Airline Manager']
          .map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        print(newValue);
        setState(() {
          _selectedLocation = newValue;
        });
      },
    );
  }
}
