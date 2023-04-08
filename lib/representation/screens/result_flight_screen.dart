
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';

import '../../core/constants/dismention_constants.dart';
import '../../core/constants/textstyle_constants.dart';

class ResultFlightScreen extends StatefulWidget {
  const ResultFlightScreen({Key? key}) : super(key: key);

  static const String routeName = '/result_flight_screen';
  final String _date = "3 Feb 2021";
  final String _passenger = "1 Adult";
  final String _type = "Economy";

  @override
  State<ResultFlightScreen> createState() => _ResultFlightScreenState();
}

class _ResultFlightScreenState extends State<ResultFlightScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
        title: Row(
          children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop([null]);
                },
                child: Container(
                  padding: const EdgeInsets.all(kItemPadding),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(kDefaultPadding)),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.black,
                    size: kDefaultIconSize,
                  ),
                ),
              ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.only(top: kDefaultPadding * 3),
                child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Text(
                      widget._date ?? '',
                      style: TextStyles
                          .defaultStyle.bold.whiteTextColor
                          .setTextSize(12),
                       ),
                        Text(
                          widget._passenger ?? '',
                          style: TextStyles
                              .defaultStyle.bold.whiteTextColor
                              .setTextSize(12),
                        ),
                        Text(
                          widget._type ?? '',
                          style: TextStyles
                              .defaultStyle.bold.whiteTextColor
                              .setTextSize(12),
                      ),
                  ]),
                ),
              ),
            ),
              Container(
                padding: const EdgeInsets.all(kItemPadding),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(kDefaultPadding)),
                  color: Colors.white,
                ),
                child: const Icon(
                  FontAwesomeIcons.bars,
                  color: Colors.black,
                  size: kDefaultIconSize,
                ),
              ),
          ],
        ),
        child: ListView(

        )
    );
  }
}
