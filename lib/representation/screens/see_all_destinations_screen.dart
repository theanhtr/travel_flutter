import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../core/constants/dismention_constants.dart';
import '../controllers/home_screen_controller.dart';
import '../widgets/app_bar_container.dart';
import 'home/home_screen.dart';

class SeeAllDestinationsScreen extends StatefulWidget {
  const SeeAllDestinationsScreen({Key? key}) : super(key: key);

  static const String routeName = '/see_all_destinations_screen';

  @override
  State<SeeAllDestinationsScreen> createState() =>
      _SeeAllDestinationsScreenState();
}

class _SeeAllDestinationsScreenState extends State<SeeAllDestinationsScreen> {
  HomeScreenController? _controller;
  List<_DestinationEntity> listItem = [];
  List<Row> listItemWidget = [];
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _controller = HomeScreenController();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded == false) {
      _controller?.getPopularDestination().then((destinations) => {
            if (destinations != false)
              {
                destinations.forEach((element) {
                  listItem.add(
                    _DestinationEntity(
                      isSelected: element['is_like'],
                      provinceId: element['province_id'],
                      provinceName: element['province_name'],
                      imagePath: element['image_path'],
                      id: element['id'],
                    ),
                  );
                }),
                for (var i = 0; i < listItem.length; i++)
                  {
                    listItemWidget.add(Row(
                      children: [
                        Expanded(
                          child: CardDestinations(
                            imagePath: listItem[i].imagePath,
                            provinceName: listItem[i].provinceName,
                            isSelected:
                                listItem[i].isSelected == 1 ? true : false,
                            onTap: () {
                              print("next screeen");
                            },
                            onChangeSelected: () {
                              _controller
                                  ?.likePopularDestination(listItem[i].id ?? 0)
                                  .then((value) =>
                                      {debugPrint(value.toString())});
                            },
                          ),
                        )
                      ],
                    )
                        //   Container(
                        //     margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2.5),
                        //     alignment: Alignment.center,
                        //     padding: const EdgeInsets.all(kDefaultPadding / 2.5),
                        //     width: MediaQuery.of(context).size.width * 0.9,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(kDefaultPadding),
                        //       color: const Color.fromARGB(255, 231, 234, 244),
                        //     ),
                        // child:
                        // )

                        ),
                  }
              },
            setState(() {})
          });
      _isLoaded = true;
    }

    return AppBarContainer(
      titleString: 'All Destinations',
      implementLeading: true,
      child: SingleChildScrollView(
        child: listItemWidget.isNotEmpty
            ? Container(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: StaggeredGrid.count(
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  children: [
                    for (var i = 0; i < listItem.length; i++)
                      StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: Container(
                            width: 50,
                            height: 25,
                            child: CardDestinations(
                              imagePath: listItem[i].imagePath,
                              provinceName: listItem[i].provinceName,
                              isSelected:
                                  listItem[i].isSelected == 1 ? true : false,
                              onTap: () {
                                print("next screeen");
                              },
                              onChangeSelected: () {
                                _controller
                                    ?.likePopularDestination(
                                        listItem[i].id ?? 0)
                                    .then((value) =>
                                        {debugPrint(value.toString())});
                              },
                            ),
                          ))
                  ],
                ))
            : const SpinKitCircle(
                color: Colors.black,
                size: 64.0,
              ),
      ),
    );
  }
}

class _DestinationEntity {
  final int? id;
  final int? provinceId;
  final String? imagePath;
  final String? provinceName;
  int isSelected;

  _DestinationEntity(
      {this.id,
      this.provinceId,
      this.imagePath,
      this.provinceName,
      required this.isSelected});
}
