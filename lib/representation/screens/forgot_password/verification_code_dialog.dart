import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/representation/screens/forgot_password/reset_password_screen.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

import '../../../core/constants/dismention_constants.dart';
import '../../../core/constants/textstyle_constants.dart';
import '../../widgets/input_card.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({Key? key, this.email}) : super(key: key);

  final String? email;

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  String? vefificationCode;
  int expires = 60;
  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(5),
  );

  @override
  Future<void> dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stopWatchTimer.onStartTimer();
    stopWatchTimer.secondTime.listen((value) => {
    setState(() {
    expires = value;
    })
    });
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 7 ,
          bottom: MediaQuery.of(context).size.height / 3,
          left: 10,
          right: 10
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Text("Verification code has been sent to ${widget.email}, please enter your code.",
                style: TextStyles
                    .defaultStyle
                    .medium
                    .blackTextColor
                    .setTextSize(
                    kDefaultTextSize),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: InputCard(
                    style: 'Verification Code',
                    onchange: (String value) {
                      vefificationCode = value;
                    },
                  ),
                ),
              ),
               SizedBox(
                 height: 100,
                 child: Center(
                   child: Text("This reset number expires in $expires seconds"),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(right: 10, left: 10),
                 child: ButtonWidget(
                    title: "Validate",
                    ontap: () {
                      Loading.show(context);
                      LoginManager().verificateCode(widget.email ?? "", vefificationCode ?? "").then((value) =>
                      {
                        debugPrint(value.toString()),
                        Loading.dismiss(context),
                        if (value == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPasswordScreen(email: widget.email, verificationCode: vefificationCode)
                                )
                            )
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('ERROR VERIFICATION CODE'),
                              content: const Text('Your code has expired or wrong code'),
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
              ),
               )
            ],
          ),
        ),
      ),
    );;
  }
}
