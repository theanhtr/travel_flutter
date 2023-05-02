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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
          // Container(
          //   padding: EdgeInsets.all(24),
          //   decoration: BoxDecoration(
          //       color: Colors.black,
          //       borderRadius: BorderRadius.circular(kDefaultPadding)),
          // ),
          // LocalStorageHelper.getValue("roleId") == 1
          //     ? TextButton(
          //         onPressed: () => showDialog<String>(
          //           context: context,
          //           builder: (BuildContext context) => AlertDialog(
          //             title: const Text('AlertDialog Title'),
          //             content: const Text('AlertDialog description'),
          //             actions: <Widget>[
          //               TextButton(
          //                 onPressed: () => Navigator.pop(context, 'Cancel'),
          //                 child: const Text('Cancel'),
          //               ),
          //               TextButton(
          //                 onPressed: () => Navigator.pop(context, 'OK'),
          //                 child: const Text('OK'),
          //               ),
          //             ],
          //           ),
          //         ),
          //         child: const Text('Show Dialog'),
          //       )
          //     : SizedBox(
          //         height: 0,
          //       ),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Select role to change'),
                content: DropdownButtonCustom(),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Change role'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
            child: const Text('Change role'),
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
