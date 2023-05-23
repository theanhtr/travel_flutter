import 'package:flutter/material.dart';
import 'package:travel_app_ytb/helpers/asset_helper.dart';
import 'package:travel_app_ytb/helpers/image_helper.dart';
import 'package:travel_app_ytb/helpers/local_storage_helper.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/screens/admin_screen.dart';
import 'package:travel_app_ytb/representation/screens/intro_screen.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/screens/main_screen.dart';

/*màn chạy khởi động khi vào app*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _redirectIntroScreen() async {
    final ignoreIntroScreen =
        await LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;
    if (ignoreIntroScreen != null && ignoreIntroScreen) {
      LoginManager().isLogin().then((value) => {
            if (value == true)
              {
                if (LocalStorageHelper.getValue("roleId") == 1)
                  {Navigator.popAndPushNamed(context, AdminScreen.routeName)}
                else
                  {Navigator.popAndPushNamed(context, MainScreen.routeName)}
              }
            else
              {Navigator.popAndPushNamed(context, LoginScreen.routeName)}
          });
    } else {
      LocalStorageHelper.setValue('ignoreIntroScreen', true);
      Navigator.of(context).pushNamed(IntroScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    _redirectIntroScreen();
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
