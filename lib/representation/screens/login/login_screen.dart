import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/core/constants/textstyle_constants.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/http/base_client.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_facebook_manager.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_google_manager.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/controllers/login_screen_controller.dart';
import 'package:travel_app_ytb/representation/screens/admin_screen.dart';
import 'package:travel_app_ytb/representation/screens/forgot_password/forgot_password_screen.dart';
import 'package:travel_app_ytb/representation/screens/home/home_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';
import 'package:travel_app_ytb/representation/screens/sign_up_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_icon_widget.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/input_card.dart';
import 'package:travel_app_ytb/representation/widgets/line_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../../../core/utils/animation_utils.dart';
import '../../../helpers/translations/localization_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";
  String token = "";
  bool rememberMe = true;
  LoginScreenController? _controller;

  Future<String> _fillEmail() async {
    if (await LocalStorageHelper.getValue("email") != null) {
      return await LocalStorageHelper.getValue("email");
    } else {
      return " ";
    }
  }

  Future<String> _fillPassword() async {
    if (await LocalStorageHelper.getValue("password") != null) {
      return await LocalStorageHelper.getValue("password");
    } else {
      return " ";
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = LoginScreenController();
    _fillEmail().then((value) => {
          if (email.isEmpty)
            {
              setState(() {
                email = value;
              })
            }
        });
    _fillPassword().then((value) => password = value);
    return AppBarContainer(
      titleString: LocalizationText.login,
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
                style: TypeInputCard.email,
                onchange: (String value) {
                  email = value;
                },
                value: email,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                  style: TypeInputCard.password,
                  onchange: (String value) {
                    password = value;
                  },
                  value: password),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return GestureDetector(
                    onTap: () {
                      rememberMe = !rememberMe;
                      setState(() {
                        LoginManager().remember(rememberMe);
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(kDefaultPadding / 1.5),
                          decoration: BoxDecoration(
                            color: ColorPalette.cardBackgroundColor,
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding / 2),
                          ),
                          child: rememberMe
                              // ignore: prefer_const_constructors
                              ? Icon(
                                  FontAwesomeIcons.accessibleIcon,
                                  color: ColorPalette.primaryColor,
                                  size: kDefaultTextSize / 1.4,
                                )
                              : Container(),
                        ),
                        const SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        Text(
                          LocalizationText.rememberMe,
                          style: TextStyles.defaultStyle.light.blackTextColor
                              .setTextSize(kDefaultTextSize / 1.2),
                        ),
                      ],
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ForgotPasswordScreen.routeName);
                  },
                  child: Container(
                    height: 22,
                    child: Text(
                      LocalizationText.forgotPassword,
                      style: TextStyles.defaultStyle.light.blackTextColor
                          .setTextSize(kDefaultTextSize / 1.2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ButtonWidget(
              title: LocalizationText.login,
              ontap: () {
                if (rememberMe == true) {
                  LocalStorageHelper.setValue("email", email);
                  LocalStorageHelper.setValue("password", password);
                } else {
                  LocalStorageHelper.deleteValue("email");
                  LocalStorageHelper.deleteValue("password");
                }
                Loading.show(context);
                _controller?.loginByPassWord(email, password).then((value) => {
                      if (value['success'] == true)
                        {
                          LocalStorageHelper.setValue(
                              "roleId", value['data']['role_id']),
                          Loading.dismiss(context),
                          if (value['data']['role_id'] == 1)
                            Navigator.popAndPushNamed(
                                context, MainScreen.routeName)
                          else if (value['data']['role_id'] == 2)
                            Navigator.popAndPushNamed(
                                context, AdminScreen.routeName)
                        }
                      else
                        {
                          Loading.dismiss(context),
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('ERROR YOUR PASSWORD'),
                              content: const Text(
                                  'Your password or email is wrong, please re-enter'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          )
                        },
                      Loading.dismiss(context)
                    });
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: ColorPalette.lightGray,
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Text(
                  LocalizationText.orLoginWith,
                  style: TextStyles.defaultStyle.blackTextColor
                      .setTextSize(kDefaultTextSize / 1.1),
                ),
                const SizedBox(
                  width: kDefaultPadding / 2,
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: ColorPalette.lightGray,
                  ),
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
                    ontap: () {
                      Loading.show(context);
                      LoginGoogleManager().signInWithGoogle().then((value) {
                        if (value != null) {
                          Loading.dismiss(context);
                          Navigator.popAndPushNamed(
                              context, MainScreen.routeName);
                        } else {
                          Loading.dismiss(context);
                        }
                      });
                      // Navigator.of(context).pushNamed(MainScreen.routeName);
                    },
                  ),
                ),
                SizedBox(width: kDefaultPadding / 2),
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
                    ontap: () async {
                      Loading.show(context);
                      LoginFacebookManager().signInWithFacebook().then((value) {
                        if (value != null) {
                          Loading.dismiss(context);
                          Navigator.popAndPushNamed(
                              context, MainScreen.routeName);
                        } else {
                          Loading.dismiss(context);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      LocalizationText.dontHaveAnAccount,
                      style: TextStyles.defaultStyle.blackTextColor
                          .setTextSize(kDefaultTextSize / 1.1),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('ok');
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Container(
                        height: 22,
                        child: Text(
                          LocalizationText.signUp,
                          style: TextStyles.defaultStyle.primaryTextColor.bold
                              .setTextSize(kDefaultTextSize / 1.1),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
