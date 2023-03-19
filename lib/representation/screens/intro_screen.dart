import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/screens/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  static const routeName = 'intro_screen';

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  final StreamController<double> _pageStreamController =
      StreamController<double>.broadcast();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      _pageStreamController.add(_pageController.page!.toDouble());
    }); //hàm chạy vào mỗi khi có sự kiện
  }

  Widget _buildItemIntroScreen(
      String image, String title, String description, Alignment alignment) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          alignment: alignment,
          child: ImageHelper.loadFromAsset(image,
               fit: BoxFit.fitHeight)
      ),
      const SizedBox(
        height: kMediumPadding * 2,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: TextStyles.defaultStyle.bold.fontHeader,
          ),
          const SizedBox(
            height: kMediumPadding * 1.2,
          ),
          Text(
            description,
            style: TextStyles.defaultStyle,
          )
        ]),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    String title1 = 'Book a flight';
    String description1 =
        'Found a flight that matches your destination and schedule? Book it instantly.';
    String title2 = 'Find a hotel room';
    String description2 =
        'Select the day, book your room. We give you the best price.';
    String title3 = 'Enjoy your trip';
    String description3 =
        'Easy discovering new places and share these between your friends and travel together.';
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildItemIntroScreen(AssetHelper.imageIntro1, title1,
                  description1, Alignment.centerRight),
              _buildItemIntroScreen(AssetHelper.imageIntro2, title2,
                  description2, Alignment.center),
              _buildItemIntroScreen(AssetHelper.imageIntro3, title3,
                  description3, Alignment.centerLeft),
            ],
          ),
          Positioned(
            left: kMediumPadding,
            right: kMediumPadding,
            bottom: kMediumPadding * 2,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        dotWidth: kMinPadding,
                        dotHeight: kMinPadding,
                        activeDotColor: Colors.orange,
                      )),
                ),
                StreamBuilder<double>(
                    initialData: 0,
                    stream: _pageStreamController.stream,
                    builder: (context, snapshot) {
                      return Expanded(
                          flex: 4,
                          child: ButtonWidget(
                            title:
                                ((snapshot.data! >= 1.6 && snapshot.data! <= 2)
                                    ? 'Get Started'
                                    : 'Next'),
                            ontap: () {
                              if (_pageController.page == 2) {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              } else {
                                _pageController.nextPage(
                                    duration: const Duration(microseconds: 200),
                                    curve: Curves.linear);
                              }
                            },
                          )
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
