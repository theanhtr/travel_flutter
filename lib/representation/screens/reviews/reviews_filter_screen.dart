import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import '../../../core/constants/color_palatte.dart';
import '../../../core/constants/dismention_constants.dart';
import '../../../core/constants/textstyle_constants.dart';
import '../../../helpers/asset_helper.dart';
import '../../../helpers/filterManager/filter_manager.dart';
import '../../../helpers/image_helper.dart';
import '../../../helpers/translations/localization_text.dart';
import '../../models/comment_model.dart';
import '../../models/reviews_model.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/loading/loading.dart';

class ReviewsFilterScreen extends StatefulWidget {
  const ReviewsFilterScreen(
      {super.key,
      this.args = const <String, dynamic>{},
      required this.getData});

  final Map<String, dynamic> args;
  final Function(ReviewsModel) getData;

  @override
  State<ReviewsFilterScreen> createState() => ReviewsFilterScreenState();
}

class ReviewsFilterScreenState extends State<ReviewsFilterScreen> {
  var isYellow1 = false;
  var isYellow2 = false;
  var isYellow3 = false;
  var isYellow4 = false;
  var isYellow5 = false;
  String ratingAverage = "";
  String sortById = "12";
  String typeId = "1";
  List<_CheckBoxState> listCheckbox = [
    _CheckBoxState(
      facility: LocalizationText.all,
      index: 1,
      checkBoxValue: true,
    ),
    _CheckBoxState(
      facility: LocalizationText.withComment,
      index: 2,
    ),
    _CheckBoxState(
      facility: LocalizationText.withPhotos,
      index: 3,
    ),
  ];
  List<_CheckBoxState> sortByList = [
    _CheckBoxState(
      facility: LocalizationText.highToLowScore,
      index: 12,
      checkBoxValue: true,
    ),
    _CheckBoxState(
      facility: LocalizationText.lowToHighScore,
      index: 13,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.25,
      maxChildSize: 1,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return ListView(
          controller: scrollController,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 240, 242, 246),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 1.5),
                    topRight: Radius.circular(kDefaultPadding * 1.5),
                  )),
              child: Scaffold(
                body: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: kMinPadding),
                      child: Container(
                        height: 5,
                        width: 80,
                        decoration: BoxDecoration(
                          color: ColorPalette.primaryColor,
                          borderRadius: BorderRadius.circular(kItemPadding),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalizationText.choseFilter,
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize * 1.2),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                LocalizationText.type,
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize - 2),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Column(children: [
                                Column(
                                  children: List.generate(
                                    listCheckbox.length,
                                    (index) => CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      title: Text(
                                        listCheckbox[index].facility,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: listCheckbox[index].checkBoxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          for (var element in listCheckbox) {
                                            element.checkBoxValue = false;
                                          }
                                          listCheckbox[index].checkBoxValue =
                                              true;
                                          typeId =
                                              "${listCheckbox[index].index}";
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ]),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                LocalizationText.sortBy,
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize - 2),
                              ),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Column(children: [
                                Column(
                                  children: List.generate(
                                    sortByList.length,
                                    (index) => CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      title: Text(
                                        sortByList[index].facility,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: sortByList[index].checkBoxValue,
                                      onChanged: (value) {
                                        setState(() {
                                          for (var element in sortByList) {
                                            element.checkBoxValue = false;
                                          }
                                          sortByList[index].checkBoxValue =
                                              true;
                                          sortById =
                                              "${sortByList[index].index}";
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ]),
                              const SizedBox(
                                height: kDefaultPadding,
                              ),
                              Text(
                                LocalizationText.rating,
                                style: TextStyles
                                    .defaultStyle.bold.blackTextColor
                                    .setTextSize(kDefaultTextSize - 2),
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ratingAverage = "1";
                                          isYellow1 = true;
                                          isYellow2 = false;
                                          isYellow3 = false;
                                          isYellow4 = false;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow1
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ratingAverage = "2";
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = false;
                                          isYellow4 = false;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow2
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ratingAverage = "3";
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = true;
                                          isYellow4 = false;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow3
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ratingAverage = "4";
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = true;
                                          isYellow4 = true;
                                          isYellow5 = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow4
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: kMediumPadding,
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ratingAverage = "5";
                                          isYellow1 = true;
                                          isYellow2 = true;
                                          isYellow3 = true;
                                          isYellow4 = true;
                                          isYellow5 = true;
                                        });
                                      },
                                      child: SizedBox(
                                        height: kMediumPadding,
                                        child: ImageHelper.loadFromAsset(
                                            isYellow5
                                                ? AssetHelper.starYellowIcon
                                                : AssetHelper.starWhiteIcon),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              Column(
                                children: [],
                              ),
                              const SizedBox(
                                height: kMediumPadding,
                              ),
                              ButtonWidget(
                                title: LocalizationText.apply,
                                ontap: () {
                                  Loading.show(context);
                                  List listComment;
                                  List<CommentModel> listCommentModel = [];
                                  List<String> listImageDetailPath = [];
                                  num startInfo;
                                  FilterManager()
                                      .filterReviews(
                                        "${widget.args['id']}",
                                        typeId,
                                        sortById,
                                        ratingAverage,
                                      )
                                      .then((value) => {
                                            Loading.dismiss(context),
                                            debugPrint("status $value"),
                                            if (value['success'] == true)
                                              {
                                                listComment = value['data']
                                                    ['reviews'] as List,
                                                for (var element in listComment)
                                                  {
                                                    listImageDetailPath = [],
                                                    for (var elementI
                                                        in element['images'])
                                                      {
                                                        listImageDetailPath.add(
                                                            elementI['path']),
                                                      },
                                                    listCommentModel
                                                        .add(CommentModel(
                                                      id: element['id'],
                                                      comment:
                                                          element['comment'],
                                                      starRating: element[
                                                          'star_rating'],
                                                      countLike:
                                                          element['count_like'],
                                                      countDislike: element[
                                                          'count_dislike'],
                                                      userId:
                                                          element['user_id'],
                                                      hotelId:
                                                          element['hotel_id'],
                                                      typeRoomId: element[
                                                          'type_room_id'],
                                                      typeRoomName: element[
                                                          'type_room_name'],
                                                      userName:
                                                          element['user_name'],
                                                      userAvatar: element[
                                                          'user_avatar'],
                                                      listImageDetailPath:
                                                          listImageDetailPath,
                                                      updatedAt: Jiffy.parse(
                                                              element[
                                                                  'updated_at'])
                                                          .fromNow(),
                                                      isLike:
                                                          element['is_like'],
                                                      isReport:
                                                          element['is_report'],
                                                    )),
                                                  },
                                                startInfo = value['data'][
                                                                'rating_average']
                                                            .runtimeType ==
                                                        int
                                                    ? value['data']
                                                            ['rating_average']
                                                        as int
                                                    : value['data']
                                                            ['rating_average']
                                                        as double,
                                                widget.getData(ReviewsModel(
                                                  ratingAverage:
                                                      startInfo.toDouble(),
                                                  countRating: value['data']
                                                      ['count_rating'],
                                                  oneStarRating: value['data']
                                                      ['one_star_rating'],
                                                  twoStarRating: value['data']
                                                      ['two_star_rating'],
                                                  threeStarRating: value['data']
                                                      ['three_star_rating'],
                                                  fourStarRating: value['data']
                                                      ['four_star_rating'],
                                                  fiveStarRating: value['data']
                                                      ['five_star_rating'],
                                                  reviews: listCommentModel,
                                                )),
                                                Navigator.pop(context),
                                              }
                                            else if (value['result'] ==
                                                'statuscode 500')
                                              {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'INVALID INPUT PARAMETER STRUCTURE!'),
                                                    content: const Text(''),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              }
                                            else if (value['result'] ==
                                                'statuscode 401')
                                              {
                                                Loading.dismiss(context),
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'UNAUTHENTICATED!'),
                                                    content: const Text(''),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              }
                                            else if (value['result'] ==
                                                'null response')
                                              {
                                                Loading.dismiss(context),
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'NULL RESPONSE!'),
                                                    content: const Text(''),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context,
                                                                'Cancel'),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              }
                                          });
                                },
                              ),
                              const SizedBox(
                                height: kMinPadding,
                              ),
                              ButtonWidget(
                                title: LocalizationText.reset,
                                ontap: () {
                                  typeId = "1";
                                  for (var element in listCheckbox) {
                                    element.checkBoxValue = false;
                                  }
                                  listCheckbox[0].checkBoxValue = true;
                                  sortById = "12";
                                  for (var element in sortByList) {
                                    element.checkBoxValue = false;
                                  }
                                  sortByList[0].checkBoxValue = true;
                                  ratingAverage = "";
                                  isYellow1 = false;
                                  isYellow2 = false;
                                  isYellow3 = false;
                                  isYellow4 = false;
                                  isYellow5 = false;
                                  setState(() {});
                                },
                              ),
                              // ButtonWidget(
                              //   title: 'Book a room',
                              //   ontap: () {
                              //     Navigator.of(context)
                              //         .pushNamed(HotelFilterScreen.routeName);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CheckBoxState {
  final String facility;
  final int index;
  bool checkBoxValue;

  _CheckBoxState(
      {required this.facility,
      required this.index,
      this.checkBoxValue = false});
}
