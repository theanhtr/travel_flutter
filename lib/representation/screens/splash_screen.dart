import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/screens/intro_screen.dart';
import 'package:travel_app_ytb/representation/screens/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';

import '../../helpers/loginManager/login_facebook_manager.dart';

/*màn chạy khởi động khi vào app*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectIntroScreen();
  }

  void  _redirectIntroScreen() async {
    final ignoreIntroScreen =
        LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
    await Future.delayed(const Duration(seconds: 1));
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.popAndPushNamed(context, LoginScreen.routeName);
      } else {
        Navigator.popAndPushNamed(context, MainScreen.routeName);
      }
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      Navigator.of(context).pushNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          //fill cho vừa màn hình
          child: ImageHelper.loadFromAsset(
            AssetHelper.imageSplashBackground,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned.fill(
          child: ImageHelper.loadFromAsset(
            AssetHelper.imageSplashCircles,
          ),
        )
      ],
    );
  }
}
