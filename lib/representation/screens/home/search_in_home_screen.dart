import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/history/search_history.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/representation/screens/home/list_search_history_item.dart';
import 'package:travel_app_ytb/representation/screens/home/result_search_text_hotel_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../../core/constants/dismention_constants.dart';
import '../../../helpers/translations/localization_text.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/tapable_widget.dart';

class SearchInHomeScreen extends StatefulWidget {
  const SearchInHomeScreen({super.key, this.searchString});

  final String? searchString;
  static const String routeName = '/search_in_home_screen';

  @override
  State<SearchInHomeScreen> createState() => _SearchInHomeScreenState();
}

class _SearchInHomeScreenState extends State<SearchInHomeScreen> {
  String searchString = "";
  String currentLocation = "";
  bool cantLoad = true;
  final TextEditingController _controller = TextEditingController();
  List<String>? searchHistory;

  @override
  void initState() {
    super.initState();
    LocationHelper().requestPermission().then((value) => {
          LocationHelper().getStringAddressCurrent().then((value) => {
                setState(() {
                  debugPrint("30 $value");
                  currentLocation = value ?? "";
                })
              })
        });
    searchString = widget.searchString ?? "";
    _controller.text = searchString;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void getSearchHistory() {
    if (cantLoad == true) {
      SearchHistory().getSearchHistory().then((value) => {
            debugPrint("54 $value"),
            if (searchHistory?.length != value.length)
              {
                debugPrint("59 setState"),
                searchHistory = value,
                setState(() {}),
              }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    getSearchHistory();
    return AppBarContainer(
      titleString: LocalizationText.hotelBooking,
      implementLeading: true,
      onPressLeading: () {
        Navigator.pop(context, searchString);
      },
      child: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          TextField(
            onTap: () {
              cantLoad = false;
            },
            enabled: true,
            controller: _controller,
            decoration: const InputDecoration(
                hintText: 'Search your destination',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(kTopPadding),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Colors.black,
                    size: kDefaultIconSize,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      BorderRadius.all(Radius.circular(kDefaultPadding)),
                )),
            onChanged: (value) {
              searchString = value;
            },
            onSubmitted: (value) {
              String textSearch;
              textSearch = value;
              Navigator.pushNamed(
                      context, ResultSearchTextHotelScreen.routeName,
                      arguments: textSearch)
                  .then((value) => {
                        SearchHistory()
                            .getSearchHistory()
                            .then((searchHistory) => {
                                  if (searchHistory.contains(textSearch) ==
                                      false)
                                    {
                                      SearchHistory()
                                          .saveSearchHistory(textSearch)
                                          .then((value) => {
                                                setState(() {
                                                  cantLoad = true;
                                                }),
                                              }),
                                    }
                                }),
                      });
            },
          ),
          TapableWidget(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.location_on),
                  onPressed: () {
                    Navigator.pop(context, searchString);
                  },
                ),
                Expanded(
                  child: Text(
                    'Near me ($currentLocation)',
                    style: TextStyles.defaultStyle.copyWith(fontSize: 25),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                  context, ResultSearchTextHotelScreen.routeName,
                  arguments: currentLocation);
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ButtonWidget(
            title: LocalizationText.search,
            ontap: () {
              SearchHistory().getSearchHistory().then((searchHistory) => {
                    if (searchHistory.contains(_controller.text) == false)
                      {
                        SearchHistory().saveSearchHistory(_controller.text),
                      },
                    Navigator.pushNamed(
                            context, ResultSearchTextHotelScreen.routeName,
                            arguments: _controller.text)
                        .then((value) => {
                              setState(() {
                                cantLoad = true;
                              }),
                            }),
                  });
            },
          ),
          const Divider(),
          searchHistory?.isEmpty == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocalizationText.history,
                      style: TextStyles.defaultStyle.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    TapableWidget(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.topSlide,
                          title: LocalizationText.clearAllSearches,
                          desc: LocalizationText.clearAllSearchesDescription,
                          btnOkOnPress: () {
                            SearchHistory()
                                .deleteAllSearchHistory()
                                .then((value) => {
                                      setState(() {
                                        cantLoad = true;
                                      }),
                                    });
                          },
                        ).show();
                      },
                      child: Text(
                        LocalizationText.deleteAll,
                        style: TextStyles.defaultStyle.copyWith(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
          ListSearchHistoryItem(
            searchHistory: searchHistory,
            controller: _controller,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
