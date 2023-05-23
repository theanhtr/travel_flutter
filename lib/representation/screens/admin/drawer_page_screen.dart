import 'package:flutter/material.dart';
import 'package:travel_app_ytb/core/constants/color_palatte.dart';
import 'package:travel_app_ytb/core/constants/dismention_constants.dart';
import 'package:travel_app_ytb/helpers/loginManager/login_manager.dart';
import 'package:travel_app_ytb/helpers/translations/localization_text.dart';
import 'package:travel_app_ytb/representation/screens/login/login_screen.dart';
import 'package:travel_app_ytb/representation/widgets/button_widget.dart';
import 'package:travel_app_ytb/representation/widgets/loading/loading.dart';

class ButtonsInfo {
  String title;
  IconData icon;
  static const String routeName = '/drawer_admin_screen';
  ButtonsInfo({required this.title, required this.icon});
}

class Task {
  String task;
  double taskValue;
  Color color;

  Task({required this.task, required this.taskValue, required this.color});
}

int _currentIndex = 0;

List<ButtonsInfo> _buttonNames = [
  ButtonsInfo(title: LocalizationText.home, icon: Icons.home),
  // ButtonsInfo(title: "Setting", icon: Icons.settings),
  // ButtonsInfo(title: "Notifications", icon: Icons.notifications),
  // ButtonsInfo(title: "Contacts", icon: Icons.contact_phone_rounded),
  // ButtonsInfo(title: "Sales", icon: Icons.sell),
  // ButtonsInfo(title: "Marketing", icon: Icons.mark_email_read),
  // ButtonsInfo(title: "Security", icon: Icons.verified_user),
  ButtonsInfo(
      title: LocalizationText.hotelManager,
      icon: Icons.supervised_user_circle_rounded),
  ButtonsInfo(
      title: LocalizationText.userManagement, icon: Icons.verified_user),
  ButtonsInfo(title: LocalizationText.profile, icon: Icons.face),
  ButtonsInfo(title: LocalizationText.addUser, icon: Icons.plus_one_rounded),
];

class DrawerPage extends StatefulWidget {
  static const String routeName = '/drawer_admin_screen';
  Function(int index) setPage;

  @override
  _DrawerPageState createState() => _DrawerPageState();
  DrawerPage({required this.setPage});
}

class _DrawerPageState extends State<DrawerPage> {
  bool _isLogOut = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorPalette.primaryColor,
      elevation: 0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding * 2),
          child: Column(
            children: [
              ListTile(
                  title: Text(
                    LocalizationText.adminMenu,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close, color: Colors.white),
                  )),
              const SizedBox(height: 24),
              ...List.generate(
                _buttonNames.length,
                (index) => Column(
                  children: [
                    Container(
                      decoration: index == _currentIndex
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  ColorPalette.red.withOpacity(0.9),
                                  ColorPalette.orange.withOpacity(0.9),
                                ],
                              ),
                            )
                          : null,
                      child: ListTile(
                        title: Text(
                          _buttonNames[index].title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        leading: Padding(
                          padding: const EdgeInsets.all(kMinPadding),
                          child: Icon(
                            _buttonNames[index].icon,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          widget.setPage(index);
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.1,
                    ),
                  ],
                ),
              ),
              ButtonWidget(
                title: LocalizationText.logout,
                ontap: () async {
                  Loading.show(context);
                  await LoginManager().signOut().then((value) => {
                        Loading.dismiss(context),
                        if (value == true && _isLogOut == false)
                          {
                            Navigator.popAndPushNamed(
                                context, LoginScreen.routeName),
                            _isLogOut = true,
                          }
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
