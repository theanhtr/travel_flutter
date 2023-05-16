import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/helpers/adminManager/admin_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';

class DropdownButtonCustom extends StatefulWidget {
  DropdownButtonCustom({super.key, required this.onchange});
  Function onchange;
  @override
  State<DropdownButtonCustom> createState() => _DropdownButtonCustomState();
}

class _DropdownButtonCustomState extends State<DropdownButtonCustom> {
  String? _selectedLocation;
  AdminManager _controller = AdminManager();

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      iconSize: 30,
      // style: TextStyle(fontSize: ),
      value: _selectedLocation,
      dropdownColor: ColorPalette.noSelectbackgroundColor,
      items: <String>[
        LocalizationText.admin,
        LocalizationText.user,
        LocalizationText.hotelManager,
        // LocalizationText.airlineManager
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        print(newValue);
        widget.onchange(_controller.checkRoleString(newValue));

        setState(() {
          _selectedLocation = newValue;
        });
      },
    );
  }
}
