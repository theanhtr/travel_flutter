// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';

import '../../core/constants/textstyle_constants.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({
    super.key,
    required this.child,
    this.title,
    this.titleString,
    this.implementLeading = false,
    this.implementTrailing = false,
  });
  final Widget? title;
  final String? titleString;
  final Widget child;
  final bool implementLeading; //show button back or not
  final bool implementTrailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 186,
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 90,
              backgroundColor: ColorPalette.backgroundScaffoldColor,
              title: title ??
                  Row(
                    children: [
                      if (implementLeading)
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop([null]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(kItemPadding),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(kDefaultPadding)),
                              color: Colors.white,
                            ),
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Colors.black,
                              size: kDefaultIconSize,
                            ),
                          ),
                        ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(top: kDefaultPadding * 3),
                          child: Center(
                            child: Column(children: [
                              Text(
                                titleString ?? '',
                                style: TextStyles
                                    .defaultStyle.bold.whiteTextColor
                                    .setTextSize(26),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      if (implementTrailing)
                        Container(
                          padding: EdgeInsets.all(kItemPadding),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(kDefaultPadding)),
                            color: Colors.white,
                          ),
                          child: Icon(
                            FontAwesomeIcons.bars,
                            color: Colors.black,
                            size: kDefaultIconSize,
                          ),
                        ),
                    ],
                  ),
              flexibleSpace: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        gradient: Gradients.defaultGradientBackground,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          // bottomRight: Radius.circular(35),
                        )),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ImageHelper.loadFromAsset(AssetHelper.appBarOval1),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ImageHelper.loadFromAsset(AssetHelper.appBarOval2),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 5.5),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: child,
          )
        ],
      ),
    );
  }
}
