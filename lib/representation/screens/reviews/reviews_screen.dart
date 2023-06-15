import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/representation/screens/reviews/reviews_controller.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';

import '../../../helpers/asset_helper.dart';
import '../../../helpers/image_helper.dart';
import '../../models/comment_model.dart';
import '../../models/reviews_model.dart';
import '../../widgets/comment_card_wiget.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  static const String routeName = '/reviews_screen';

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String? photoUrl;
  int id = -1;
  ReviewsController? _controller;
  bool _isLoading = true;
  ReviewsModel? _reviewsModel;
  List<Widget> listCommentCardWidgets = [];
  List<XFile> listImageComment = [];
  ImagePicker? picker;
  TextEditingController _textEditingController = TextEditingController();
  bool isFocus = false;
  String ratingAverage = "1";
  var isYellow1 = true;
  var isYellow2 = false;
  var isYellow3 = false;
  var isYellow4 = false;
  var isYellow5 = false;

  @override
  void initState() {
    super.initState();
    _controller = ReviewsController();
  }

  Future<void> _initData(int id) async {
    if (_isLoading == true) {
      _controller?.getReviews(id).then(
            (value) => {
              _isLoading = false,
              _reviewsModel = value,
              for (int i = 0; i < (_reviewsModel?.reviews?.length ?? 0); i++)
                {
                  listCommentCardWidgets.add(CommentCardWidget(
                      commentModel:
                          _reviewsModel?.reviews![i] ?? CommentModel())),
                  if (i < (_reviewsModel?.reviews?.length ?? 0) - 1)
                    {
                      listCommentCardWidgets.add(
                        const SizedBox(
                          height: kMediumPadding,
                        ),
                      ),
                    }
                },
              setState(() {}),
            },
          );
    }
  }

  Future<void> _pickImage() async {
    picker = ImagePicker();
    final List<XFile>? images = await picker?.pickMultiImage();
    if (images != null) {
      setState(() {
        listImageComment.addAll(images);
      });
    }
  }

  Future<void> _pickCamera() async {
    picker = ImagePicker();
    final XFile? photo = await picker?.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        listImageComment.add(photo);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    id = args['id'];
    final orderStatusId = args['orderStatusId'] as int;
    _initData(id);

    return AppBarContainer(
      titleString: "Reviews",
      implementLeading: true,
      implementTrailing: true,
      resizeToAvoidBottomInset: true,
      child: _isLoading == false
          ? SingleChildScrollView(
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kDefaultPadding),
                    color: Colors.white,
                  ),
                  child: Row(children: [
                    Container(
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 110),
                      margin: EdgeInsets.all(kMediumPadding),
                      child: Column(
                        children: [
                          Text(
                            "${_reviewsModel?.ratingAverage}",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          Text(
                            "of 5",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "(${_reviewsModel?.countRating} Reviews)",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: kMediumPadding, bottom: kMediumPadding),
                      child: Column(children: [
                        Row(
                          children: [
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: Text(
                                    "${_reviewsModel?.fiveStarRating} Reviews (${((_reviewsModel?.fiveStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Color.fromARGB(255, 229, 229, 229),
                                    minHeight: 2,
                                    value: (_reviewsModel?.fiveStarRating ??
                                            0 /
                                                (_reviewsModel?.countRating == 0
                                                    ? 1
                                                    : (_reviewsModel
                                                            ?.countRating ??
                                                        1)))
                                        .toDouble(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: [
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: Text(
                                    "${_reviewsModel?.fourStarRating} Reviews (${((_reviewsModel?.fourStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Color.fromARGB(255, 229, 229, 229),
                                    minHeight: 2,
                                    value: (_reviewsModel?.fourStarRating ??
                                            0 /
                                                (_reviewsModel?.countRating == 0
                                                    ? 1
                                                    : (_reviewsModel
                                                            ?.countRating ??
                                                        1)))
                                        .toDouble(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: [
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: Text(
                                    "${_reviewsModel?.threeStarRating} Reviews (${((_reviewsModel?.threeStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Color.fromARGB(255, 229, 229, 229),
                                    minHeight: 2,
                                    value: (_reviewsModel?.threeStarRating ??
                                            0 /
                                                (_reviewsModel?.countRating == 0
                                                    ? 1
                                                    : (_reviewsModel
                                                            ?.countRating ??
                                                        1)))
                                        .toDouble(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: [
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: Text(
                                    "${_reviewsModel?.twoStarRating} Reviews (${((_reviewsModel?.twoStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Color.fromARGB(255, 229, 229, 229),
                                    minHeight: 2,
                                    value: (_reviewsModel?.twoStarRating ??
                                            0 /
                                                (_reviewsModel?.countRating == 0
                                                    ? 1
                                                    : (_reviewsModel
                                                            ?.countRating ??
                                                        1)))
                                        .toDouble(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: kDefaultPadding,
                        ),
                        Row(
                          children: [
                            ImageHelper.loadFromAsset(
                                AssetHelper.starYellowIcon),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            SizedBox(
                              width: kDefaultPadding,
                              child: ImageHelper.loadFromAsset(
                                  AssetHelper.starWhiteIcon),
                            ),
                            SizedBox(
                              width: kMinPadding,
                            ),
                            Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: Text(
                                    "${_reviewsModel?.oneStarRating} Reviews (${((_reviewsModel?.oneStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                      minWidth: 100, maxWidth: 100),
                                  child: LinearProgressIndicator(
                                    backgroundColor:
                                        Color.fromARGB(255, 229, 229, 229),
                                    minHeight: 2,
                                    value: (_reviewsModel?.oneStarRating ??
                                            0 /
                                                (_reviewsModel?.countRating == 0
                                                    ? 1
                                                    : (_reviewsModel
                                                            ?.countRating ??
                                                        1)))
                                        .toDouble(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: kMediumPadding,
                ),
                orderStatusId == 8
                    ? Column(
                        children: [
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
                                    child: ImageHelper.loadFromAsset(isYellow1
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
                                    child: ImageHelper.loadFromAsset(isYellow2
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
                                    child: ImageHelper.loadFromAsset(isYellow3
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
                                    child: ImageHelper.loadFromAsset(isYellow4
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
                                    child: ImageHelper.loadFromAsset(isYellow5
                                        ? AssetHelper.starYellowIcon
                                        : AssetHelper.starWhiteIcon),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onTap: () {
                              setState(() {
                                isFocus = true;
                              });
                            },
                            onTapOutside: (event) {
                              isFocus = false;
                            },
                            autofocus: isFocus,
                            controller: _textEditingController,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                                hintText: 'Vui lòng đánh giá',
                                border: OutlineInputBorder()),
                          ),
                          Row(
                            children: [
                              TapableWidget(
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                ),
                                onTap: () {
                                  _pickCamera();
                                },
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              TapableWidget(
                                child: const Icon(
                                  Icons.camera,
                                  size: 50,
                                ),
                                onTap: () {
                                  _pickImage();
                                },
                              ),
                            ],
                          ),
                          Wrap(
                            children: listImageComment
                                .asMap()
                                .entries
                                .map((e) => GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Scaffold(
                                                appBar: AppBar(
                                                  backgroundColor: Colors.white,
                                                  actions: [
                                                    Center(
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.all(8),
                                                        child: TapableWidget(
                                                          child: Text(
                                                            "Huỷ",
                                                            style: TextStyles
                                                                .defaultStyle
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                          onTap: () {
                                                            setState(() {
                                                              listImageComment
                                                                  .removeAt(
                                                                      e.key);
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                  leading: IconButton(
                                                    icon: const Icon(
                                                      Icons.arrow_back_ios,
                                                      color: Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                body: Container(
                                                  child: Center(
                                                      child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kMinPadding),
                                                    child: Image.file(
                                                      File(e.value.path),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                                ),
                                              );
                                            });
                                      },
                                      child: Image.file(
                                        File(e.value.path),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ButtonWidget(
                            title: "Submit",
                            ontap: () {
                              _controller?.sendDataToServer(_textEditingController.text, listImageComment, ratingAverage, id).then((value) => {
                                      debugPrint("$value"),
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : const SizedBox(),
                Column(
                  children: listCommentCardWidgets,
                ),
              ]),
            )
          : const SpinKitCircle(
              color: Colors.black,
              size: 64.0,
            ),
    );
  }
}
