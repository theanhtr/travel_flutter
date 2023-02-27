import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/line_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/sign_up_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Sign Up',
      implementLeading: true,
      // ignore: prefer_const_literals_to_create_immutables
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: kDefaultPadding * 5,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: 'First Name',
                onchange: (String value) {
                  firstName = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: 'Last Name',
                onchange: (String value) {
                  lastName = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: 'Email',
                onchange: (String value) {
                  email = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: 'Password',
                onchange: (String value) {
                  password = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'By tapping sign up you agree to the',
                      style: TextStyles.defaultStyle.blackTextColor
                          .setTextSize(kDefaultTextSize / 1.1),
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Terms and Condition and Privacy Policy');
                      },
                      child: Container(
                        height: 22,
                        child: Text(
                          'Terms and Condition and Privacy Policy',
                          style: TextStyles.defaultStyle.primaryTextColor.bold
                              .setTextSize(kDefaultTextSize / 1.1),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ButtonWidget(
              title: 'Sign Up',
              ontap: () {},
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Line(
                  width: 90,
                ),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Text(
                  'or sign up with',
                  style: TextStyles.defaultStyle.blackTextColor
                      .setTextSize(kDefaultTextSize / 1.1),
                ),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                const Line(
                  width: 90,
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(
                  flex: 1,
                  child: ButtonIconWidget(
                    title: 'Google',
                    backgroundColor: ColorPalette.cardBackgroundColor,
                    textColor: ColorPalette.blackTextColor,
                    icon: ImageHelper.loadFromAsset(AssetHelper.googleIcon,
                        fit: BoxFit.contain, width: kDefaultPadding * 1.5),
                    ontap: () {},
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
                Expanded(
                  flex: 1,
                  child: ButtonIconWidget(
                    title: 'Facebook',
                    backgroundColor: Color(0xff3C5A9A),
                    textColor: Color(0xffffffff),
                    icon: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                    ),
                    ontap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}
