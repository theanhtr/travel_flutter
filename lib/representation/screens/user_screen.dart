import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';

import 'login_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonWidget(
        title: "logout",
        ontap: () {
          LoginManager().signOut().then((value) =>
              {
                if (value == true) {
                  Navigator.popAndPushNamed(context, LoginScreen.routeName)
                } else {
                  FirebaseAuth.instance.signOut().then((value) =>
                      Navigator.popAndPushNamed(context, LoginScreen.routeName)
                  )
                }
              }
          );
        },
      )
    );
  }
}