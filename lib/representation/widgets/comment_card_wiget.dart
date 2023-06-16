import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_app_ytb/representation/models/comment_model.dart';
import 'package:travel_app_ytb/representation/widgets/tapable_widget.dart';

import '../../core/constants/dismention_constants.dart';
import '../../helpers/asset_helper.dart';
import '../../helpers/image_helper.dart';
import '../../helpers/translations/localization_text.dart';
import '../screens/reviews/reviews_controller.dart';
import 'loading/loading.dart';

class CommentCardWidget extends StatefulWidget {
  const CommentCardWidget({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  List<Widget> starWidget = [];
  String commentText = "";
  String? commentTextShort;
  String? curCommentText;
  String textButton = "See More";
  List<Widget> listImageWidgets = [];
  List<Widget> listImageWidgetsFull = [];
  Widget imageWidget = Container();
  Color? likeColor = Colors.black;
  Color? dislikeColor = Colors.black;
  Color? reportColor = Colors.black;
  ReviewsController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ReviewsController();
    if (widget.commentModel.isLike == 1) {
      likeColor = Colors.blue;
    } else if (widget.commentModel.isLike == 0) {
      dislikeColor = Colors.blue;
    }
    if (widget.commentModel.isReport == 1) {
      reportColor = Colors.blue;
    }

    commentText = widget.commentModel.comment ?? "";

    curCommentText = commentText;
    if (commentText.length > 72) {
      commentTextShort = commentText.substring(0, 71) + "...";
      curCommentText = commentTextShort;
    }

    for (int i = 0; i < 3; i++) {
      if (i < 2) {
        if (i < (widget.commentModel.listImageDetailPath?.length ?? 0)) {
          listImageWidgets.add(Expanded(
            flex: 1,
            child: TapableWidget(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
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
                        body: Center(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(kMinPadding),
                          child: Image.network(
                            widget.commentModel.listImageDetailPath![i],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: const SpinKitCircle(
                                  color: Colors.black,
                                  size: 20.0,
                                ),
                              );
                            },
                          ),
                        )),
                      );
                    });
              },
              child: Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(kMinPadding),
                child: Image.network(
                  widget.commentModel.listImageDetailPath![i],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: const SpinKitCircle(
                        color: Colors.black,
                        size: 20.0,
                      ),
                    );
                  },
                ),
              )),
            ),
          ));
        } else {
          listImageWidgets.add(
            Expanded(flex: 1, child: Container()),
          );
        }
        listImageWidgets.add(
          SizedBox(
            width: kDefaultPadding,
          ),
        );
      } else if (i == 2) {
        if (i < (widget.commentModel.listImageDetailPath?.length ?? 0)) {
          listImageWidgets.add(
            Expanded(
              flex: 1,
              child: TapableWidget(
                onTap: () {
                  imageWidget = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listImageWidgetsFull,
                  );
                  setState(() {});
                },
                child: Container(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(kMinPadding),
                        child: Image.network(
                          widget.commentModel.listImageDetailPath![i],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: const SpinKitCircle(
                                color: Colors.black,
                                size: 20.0,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            minWidth: 100,
                            maxWidth: 100,
                            minHeight: 100,
                            maxHeight: 100),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(100, 0, 0, 0),
                          borderRadius: BorderRadius.circular(kMinPadding),
                        ),
                        child: Center(
                          child: Text(
                            "+${(widget.commentModel.listImageDetailPath?.length ?? 0) - 2}",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          listImageWidgets.add(
            Expanded(flex: 1, child: Container()),
          );
        }
      }
    }
    ;
    for (int i = 0;
        i < (widget.commentModel.listImageDetailPath?.length ?? 0 / 3).ceil();
        i++) {
      List<Widget> listWidget = [];
      for (int j = i * 3; j < i * 3 + 3; j++) {
        if (j < i * 3 + 2) {
          if (j < (widget.commentModel.listImageDetailPath?.length ?? 0)) {
            listWidget.add(Expanded(
              flex: 1,
              child: TapableWidget(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scaffold(
                          body: Container(
                            child: Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(kMinPadding),
                              child: Image.network(
                                widget.commentModel.listImageDetailPath![j],
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: const SpinKitCircle(
                                      color: Colors.black,
                                      size: 20.0,
                                    ),
                                  );
                                },
                              ),
                            )),
                          ),
                        );
                      });
                },
                child: Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(kMinPadding),
                  child: Image.network(
                    widget.commentModel.listImageDetailPath![j],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: const SpinKitCircle(
                          color: Colors.black,
                          size: 20.0,
                        ),
                      );
                    },
                  ),
                )),
              ),
            ));
          } else {
            listWidget.add(
              Expanded(flex: 1, child: Container()),
            );
          }
          listWidget.add(
            SizedBox(
              width: kDefaultPadding,
            ),
          );
        } else if (j == i * 3 + 2) {
          if (j < (widget.commentModel.listImageDetailPath?.length ?? 0)) {
            listWidget.add(
              Expanded(
                flex: 1,
                child: TapableWidget(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Scaffold(
                            body: Container(
                              child: Center(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(kMinPadding),
                                  child: Image.network(
                                    widget.commentModel.listImageDetailPath![j],
                                    // width: kDefaultIconSize * 2.5,
                                    // height: kDefaultIconSize * 2.5,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: const SpinKitCircle(
                                          color: Colors.black,
                                          size: 20.0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(kMinPadding),
                    child: Image.network(
                      widget.commentModel.listImageDetailPath![j],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: const SpinKitCircle(
                            color: Colors.black,
                            size: 20.0,
                          ),
                        );
                      },
                    ),
                  )),
                ),
              ),
            );
          } else {
            listWidget.add(
              Expanded(flex: 1, child: Container()),
            );
          }
          break;
        }
      }
      ;
      listImageWidgetsFull.add(Row(
        children: listWidget,
      ));
      listImageWidgetsFull.add(
        SizedBox(
          height: kDefaultPadding,
        ),
      );
      if (i == (widget.commentModel.listImageDetailPath?.length ?? 0) - 1) {
        listImageWidgetsFull.add(TapableWidget(
          onTap: () {
            imageWidget = Row(
              children: listImageWidgets,
            );
            setState(() {});
          },
          child: Text(
            "See Less",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 101, 88, 88)),
          ),
        ));
      }
    }
    ;
    imageWidget = Row(
      children: listImageWidgets,
    );

    for (int i = 0; i < 5; i++) {
      if (i < (widget.commentModel.starRating ?? 0)) {
        starWidget.add(
          ImageHelper.loadFromAsset(AssetHelper.starYellowIcon),
        );
      } else {
        starWidget.add(
          SizedBox(
            width: kDefaultPadding,
            child: ImageHelper.loadFromAsset(AssetHelper.starWhiteIcon),
          ),
        );
      }
      if (i != 4) {
        starWidget.add(
          SizedBox(
            width: kMinPadding,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: widget.commentModel.userAvatar != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(kMinPadding),
                        child: Image.network(
                          widget.commentModel.userAvatar!,
                          width: kDefaultIconSize * 2.5,
                          height: kDefaultIconSize * 2.5,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: const SpinKitCircle(
                                color: Colors.black,
                                size: 20.0,
                              ),
                            );
                          },
                        ),
                      )
                    : ImageHelper.loadFromAsset(
                        AssetHelper.userAvatar,
                        width: kDefaultIconSize * 2.5,
                        radius: BorderRadius.circular(kMinPadding),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.commentModel.userName ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: kMinPadding,
                    ),
                    Text(
                      widget.commentModel.updatedAt ?? "",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Container(
                alignment: Alignment.topRight,
                child: Row(
                  children: starWidget,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curCommentText!,
                  style: TextStyle(fontSize: 17),
                ),
                commentTextShort == null
                    ? Container()
                    : TapableWidget(
                        onTap: () {
                          if (textButton == "See More") {
                            curCommentText = commentText;
                            textButton = "See Less";
                          } else {
                            curCommentText = commentTextShort;
                            textButton = "See More";
                          }
                          setState(() {});
                        },
                        child: Text(
                          textButton,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 101, 88, 88)),
                        ),
                      )
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          imageWidget,
          SizedBox(
            height: kDefaultPadding,
          ),
          Container(
            width: 1000,
            child: ImageHelper.loadFromAsset(AssetHelper.dottedLine,
                tintColor: Colors.black),
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              TapableWidget(
                onTap: () {
                  Loading.show(context);
                  if (likeColor == Colors.black) {
                    _controller
                        ?.likeReview('${widget.commentModel.id}', "1")
                        .then((value) => {
                              Loading.dismiss(context),
                              if (value == true)
                                {
                                  widget.commentModel.countLike =
                                      widget.commentModel.countLike! + 1,
                                  likeColor = Colors.blue,
                                  if (dislikeColor == Colors.blue)
                                    {
                                      widget.commentModel.countDislike =
                                          widget.commentModel.countDislike! - 1,
                                      dislikeColor = Colors.black,
                                    },
                                  setState(() {}),
                                }
                            });
                  } else {
                    _controller
                        ?.likeReview('${widget.commentModel.id}', "3")
                        .then((value) => {
                              Loading.dismiss(context),
                              if (value == true)
                                {
                                  widget.commentModel.countLike =
                                      widget.commentModel.countLike! - 1,
                                  likeColor = Colors.black,
                                  setState(() {}),
                                }
                            });
                  }
                },
                child: ImageHelper.loadFromAsset(AssetHelper.likeIcon,
                    height: kDefaultIconSize * 1.5, tintColor: likeColor),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Text(
                '${widget.commentModel.countLike}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              TapableWidget(
                onTap: () {
                  Loading.show(context);
                  if (dislikeColor == Colors.black) {
                    _controller
                        ?.likeReview('${widget.commentModel.id}', "2")
                        .then((value) => {
                              Loading.dismiss(context),
                              if (value == true)
                                {
                                  widget.commentModel.countDislike =
                                      widget.commentModel.countDislike! + 1,
                                  dislikeColor = Colors.blue,
                                  if (likeColor == Colors.blue)
                                    {
                                      widget.commentModel.countLike =
                                          widget.commentModel.countLike! - 1,
                                      likeColor = Colors.black,
                                    },
                                  setState(() {}),
                                }
                            });
                  } else {
                    _controller
                        ?.likeReview('${widget.commentModel.id}', "3")
                        .then((value) => {
                              Loading.dismiss(context),
                              if (value == true)
                                {
                                  widget.commentModel.countDislike =
                                      widget.commentModel.countDislike! - 1,
                                  dislikeColor = Colors.black,
                                  setState(() {}),
                                }
                            });
                  }
                },
                child: ImageHelper.loadFromAsset(AssetHelper.dislikeIcon,
                    height: kDefaultIconSize * 1.5, tintColor: dislikeColor),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              Text(
                '${widget.commentModel.countDislike}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              TapableWidget(
                onTap: () {
                  if (reportColor == Colors.black) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      title: "Bạn có chắc chắn muốn báo cáo nội dung này?",
                      btnOkOnPress: () {
                        _controller
                            ?.reportReview('${widget.commentModel.id}')
                            .then((value) => {
                                  if (value == true)
                                    {
                                      reportColor = Colors.blue,
                                      setState(() {}),
                                    }
                                });
                      },
                      btnCancelOnPress: () {},
                    ).show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      title: "Bạn đã báo cáo nội dung này rồi!",
                      btnOkOnPress: () {},
                    ).show();
                  }
                },
                child: ImageHelper.loadFromAsset(AssetHelper.threeDotIcon,
                    height: kDefaultIconSize / 2, tintColor: reportColor),
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
