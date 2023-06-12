import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/location/location_helper.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/controllers/hotel_booking_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/search_your_destination_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/search_hotels_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_date_screen.dart';
import 'package:travel_app_ytb/representation/screens/hotel_booking/select_guest_room_screen.dart';
import 'package:travel_app_ytb/representation/screens/reviews/reviews_controller.dart';
import 'package:travel_app_ytb/representation/screens/reviews/reviews_filter_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_ytb/representation/widgets/booking_hotel_tab_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/core/extensions/date_ext.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';

import '../../../core/utils/navigation_utils.dart';
import '../../../helpers/asset_helper.dart';
import '../../../helpers/image_helper.dart';
import '../../models/comment_model.dart';
import '../../models/reviews_model.dart';
import '../../widgets/comment_card_wiget.dart';
import '../hotel_detail/hotel_detail_screen.dart';

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
                        SizedBox(
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

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    id = args['id'];
    _initData(id);

    return AppBarContainer(
      titleString: LocalizationText.reviews,
      implementLeading: true,
      implementTrailing: true,
      useFilter: true,
      widget: ReviewsFilterScreen(
        args: args,
        getData: (data) {
          _reviewsModel = data;
          listCommentCardWidgets = [];
          for (int i = 0; i < (_reviewsModel?.reviews?.length ?? 0); i++) {
            listCommentCardWidgets.add(CommentCardWidget(
                commentModel: _reviewsModel?.reviews![i] ?? CommentModel()));
            if (i < (_reviewsModel?.reviews?.length ?? 0) - 1) {
              listCommentCardWidgets.add(
                SizedBox(
                  height: kMediumPadding,
                ),
              );
            }
          }
          ;
          setState(() {});
        },
      ),
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
                            "/5",
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "(${_reviewsModel?.countRating} ${LocalizationText.reviews})",
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
                                    "${_reviewsModel?.fiveStarRating} ${LocalizationText.reviews} (${((_reviewsModel?.fiveStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
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
                                    "${_reviewsModel?.fourStarRating} ${LocalizationText.reviews} (${((_reviewsModel?.fourStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
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
                                    "${_reviewsModel?.threeStarRating} ${LocalizationText.reviews} (${((_reviewsModel?.threeStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
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
                                    "${_reviewsModel?.twoStarRating} ${LocalizationText.reviews} (${((_reviewsModel?.twoStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
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
                                    "${_reviewsModel?.oneStarRating} ${LocalizationText.reviews} (${((_reviewsModel?.oneStarRating ?? 0 / (_reviewsModel?.countRating == 0 ? 1 : (_reviewsModel?.countRating ?? 1))) * 100).toStringAsFixed(0)}%)",
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
                SizedBox(
                  height: kMediumPadding,
                ),
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
