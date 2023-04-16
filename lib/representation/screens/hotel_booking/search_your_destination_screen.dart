import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/controllers/search_your_destination_screen_controller.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../../helpers/translations/localization_text.dart';
import '../../widgets/button_widget.dart';

class SearchYourDestinationScreen extends StatefulWidget {
  const SearchYourDestinationScreen({Key? key}) : super(key: key);
  static const String routeName = '/search_your_destination_screen';

  @override
  State<SearchYourDestinationScreen> createState() => _SearchYourDestinationScreenState();
}

class _SearchYourDestinationScreenState extends State<SearchYourDestinationScreen> {
  SearchYourDestinationScreenController? _controller;

  final List<Map<String, dynamic>> provinceItems = [{"id": "0","name":"None"}];
  final List<Map<String, dynamic>> districtItems = [
    {"id": "0","name":"None"}
  ];
  final List<Map<String, dynamic>> subDistrictItems = [
    {"id": "0","name":"None"}
  ];
  bool isLoadProvince = false;
  bool isLoadDistricts = false;
  bool isLoadSubDistricts = false;

  Map<String, dynamic>? selectedProvinceValue;
  Map<String, dynamic>? selectedDistrictValue;
  Map<String, dynamic>? selectedSubDistrictValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller = SearchYourDestinationScreenController();
    final Map<String, dynamic> argss =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    if (isLoadProvince == false ) {
      selectedProvinceValue = argss['selectedProvinceValue'] ?? {"id": "0","name":"None"};
      selectedDistrictValue = argss['selectedDistrictValue'] ?? {"id": "0","name":"None"};
      selectedSubDistrictValue = argss['selectedSubDistrictValue'] ?? {"id": "0","name":"None"};
      _controller?.getProvince().then((province) => {
        if (province.runtimeType == List) {
          province as List,
          province.forEach((element) {
            provinceItems.add(element);
          }),
          setState(() {
            isLoadProvince = true;
          })
        }
      });
    }
    if (provinceItems.isEmpty == false) {
      return AppBarContainer(
          implementLeading: true,
          titleString: "Search your destination",
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              DropdownSearch<Map<String, dynamic>>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: false,
                ),
                items: provinceItems,
                itemAsString: (Map<String, dynamic> value) => value['name'],
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Province",
                    hintText: "Province in mode",
                  ),
                ),
                onChanged: (value) {
                  selectedProvinceValue = value;
                  setState(() {
                    isLoadDistricts = false;
                  });
                  if (isLoadDistricts == false) {
                    _controller?.getDistricts(selectedProvinceValue?['id'].toString() ?? "").then((district) => {
                      districtItems.clear(),
                      districtItems.add({"id": "0","name":"None"}),
                      if (district.runtimeType == List) {
                        district as List,
                        district.forEach((element) {
                          districtItems.add(element);
                        }),
                        setState(() {
                          isLoadDistricts = true;
                        })
                      }
                    });
                  }
                },
                selectedItem: selectedProvinceValue,
              ),
              DropdownSearch<Map<String, dynamic>>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: false,
                ),
                items: districtItems,
                itemAsString: (Map<String, dynamic> value) => value['name'],
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "District",
                    hintText: "District in mode",
                  ),
                ),
                onChanged: (value) {
                  selectedDistrictValue = value;
                  setState(() {
                    isLoadSubDistricts = false;
                  });
                  if (isLoadSubDistricts == false) {
                    _controller?.getSubDistricts(selectedDistrictValue?['id'].toString() ?? "").then((subDistrict) => {
                      subDistrictItems.clear(),
                      subDistrictItems.add({"id": "0","name":"None"}),
                      if (subDistrict.runtimeType == List) {
                        subDistrict as List,
                        subDistrict.forEach((element) {
                          subDistrictItems.add(element);
                        }),
                        setState(() {
                          isLoadSubDistricts = true;
                        })
                      }
                    });
                  }
                },
                selectedItem: selectedDistrictValue,
              ),
              DropdownSearch<Map<String, dynamic>>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: false,
                ),
                items: subDistrictItems,
                itemAsString: (Map<String, dynamic> value) => value['name'],
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "SubDistrict",
                    hintText: "SubDistrict in mode",
                  ),
                ),
                onChanged: (value) {
                  selectedSubDistrictValue = value;
                },
                selectedItem: selectedSubDistrictValue,
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonWidget(
                title: LocalizationText.done,
                ontap: () {
                  Navigator.of(context).pop([selectedProvinceValue, selectedDistrictValue, selectedSubDistrictValue]);
                },
              ),
            ],
          )
      );
    }
    return AppBarContainer(
        implementLeading: true,
        titleString: "Search your destination",
        child: Column(
          children: const [
            SizedBox(
              height: 40,
            ),
          ],
        )
    );
  }
}
