import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/widgets/app_bar_container.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../../../core/constants/dismention_constants.dart';
import '../../widgets/input_card.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, this.email, this.verificationCode});

  static const String routeName = '/reset_password_screen';
  final String? email;
  final String? verificationCode;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String password = "";
  String passwordConfirm = "";

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      titleString: 'Reset Password',
      implementLeading: true,
      // ignore: prefer_const_literals_to_create_immutables
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: kDefaultPadding * 3,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.password,
                onchange: (String value) {
                  password = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 3,
            ),
            StatefulBuilder(
              builder: (context, setState) => InputCard(
                style: TypeInputCard.passwordConfirm,
                onchange: (String value) {
                  passwordConfirm = value;
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 3,
            ),
            ButtonWidget(
              title: "Send",
              ontap: () {
                Loading.show(context);
                LoginManager().resetPassword(widget.email ?? "", password, passwordConfirm, widget.verificationCode ?? "").then((value) => {
                  Loading.dismiss(context),
                  print(value),
                  if (value == true) {
                    Navigator.popAndPushNamed(context, LoginScreen.routeName)
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Cannot reset your password'),
                        content: const Text('Please check your new password and your confirm password'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    )
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
