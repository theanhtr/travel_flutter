import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

import 'login/login_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool _isLogOut = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ButtonWidget(
      title: LocalizationText.logout,
      ontap: () {
        LoginManager().signOut().then((value) => {
              if (value == true && _isLogOut == false)
                {
                  Navigator.popAndPushNamed(context, LoginScreen.routeName),
                  _isLogOut = true,
                }
            });
      },
    ));
  }
}
